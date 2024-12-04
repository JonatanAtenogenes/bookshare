import 'dart:developer';

import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/book/api_book_provider.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/book/api_isbn_book_provider.dart';
import '../view_models/user/user_provider.dart';

/// Provides a `StateProvider` to manage an instance of the `BookData` class.
///
/// The `BookData` class acts as a centralized manager for handling
/// book-related operations such as retrieving user books, fetching all books,
/// retrieving books by ISBN, and saving books. The `bookDataProvider` uses
/// Riverpod's dependency injection system to provide access to the `BookData`
/// instance throughout the application.
final bookDataProvider = StateProvider<BookData>((ref) {
  return BookData(ref);
});

/// A class to handle book-related operations.
///
/// The `BookData` class centralizes logic for managing books within the
/// application. It interacts with various Riverpod providers to perform
/// asynchronous tasks such as fetching books, saving a book, and retrieving
/// book information by ISBN. This class ensures proper state management,
/// including updating loading states and handling errors.
class BookData {
  /// The Riverpod `Ref` object used to access and manage providers.
  final Ref ref;

  /// Initializes a `BookData` instance with the provided `Ref` object.
  BookData(this.ref);

  /// Fetches the list of books belonging to the current user.
  ///
  /// This method performs the following steps:
  /// 1. Updates the `loadingUserBookListProvider` to indicate that the
  ///    request is in progress.
  /// 2. Reads the current user's ID and retrieves the user's books by calling
  ///    the `retrieveUserBooks` method from the `apiUserBookListNotifierProvider`.
  /// 3. Updates the `userBooksProvider` with the fetched list of books.
  /// 4. Logs the fetched book list.
  /// 5. Handles errors by logging them and updating the error state in
  ///    `apiUserBookListNotifierProvider`.
  /// 6. Updates the `loadingUserBookListProvider` to indicate that the
  ///    request has completed.
  Future<void> getUserBooks() async {
    ref.read(loadingUserBookListProvider.notifier).update((state) => true);
    try {
      final userId = ref.read(currentUserProvider).id;

      await ref
          .read(apiUserBookListNotifierProvider.notifier)
          .retrieveUserBooks(userId);

      ref.read(userBooksProvider.notifier).update(
            (state) => ref.read(apiUserBookListNotifierProvider).data!,
          );

      log("\n----------------------");
      log("User Books ${ref.read(userBooksProvider)}");
    } on DioException catch (e) {
      log('Error fetching user books: ${e.toString()}');
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiUserBookListNotifierProvider.notifier)
          .updateErrorOnRetrievingBooks(
            message,
          );
    } finally {
      ref.read(loadingUserBookListProvider.notifier).update((state) => false);
    }
  }

  Future<void> getSelectedUserBooks() async {
    ref.read(loadingSelectedUserBookListProvider.notifier).update(
          (state) => true,
        );
    try {
      final userId = ref.read(selectedUserProvider).id;

      log("Selected user id = $userId \n");

      await ref
          .read(apiSelectedUserBookListNotifierProvider.notifier)
          .retrieveUserBooks(userId);

      ref.read(selectedUserBooksProvider.notifier).update(
            (state) => ref.read(apiSelectedUserBookListNotifierProvider).data!,
          );

      log("\n----------------------");
      log("User Books ${ref.read(selectedUserProvider)}");
    } on DioException catch (e) {
      log('Error fetching user books: ${e.toString()}');
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiSelectedUserBookListNotifierProvider.notifier)
          .updateErrorOnRetrievingBooks(
            message,
          );
    } finally {
      ref
          .read(loadingSelectedUserBookListProvider.notifier)
          .update((state) => false);
    }
  }

  /// Fetches all books excluding the books of the current user.
  ///
  /// This method:
  /// - Updates the `loadingAllBookListProvider` to indicate the start of the request.
  /// - Retrieves books from the API using the `retrieveBooks` method from the
  ///   `apiAllBookListNotifierProvider`.
  /// - Updates the `listOfBooksProvider` with the fetched books.
  /// - Handles errors by logging them and updating the error state in
  ///   `apiAllBookListNotifierProvider`.
  /// - Updates the `loadingAllBookListProvider` after the operation.
  Future<void> getBooks() async {
    ref.read(loadingAllBookListProvider.notifier).update((state) => true);
    try {
      final userId = ref.read(currentUserProvider).id;
      await ref.read(apiAllBookListNotifierProvider.notifier).retrieveBooks(
            userId,
          );
      ref.read(listOfBooksProvider.notifier).update(
            (state) => ref
                .read(apiAllBookListNotifierProvider)
                .data!
                .reversed
                .toList(),
          );
    } on DioException catch (e) {
      log('Error fetching books: ${e.toString()}');
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiAllBookListNotifierProvider.notifier)
          .updateErrorOnRetrievingBooks(
            message,
          );
    } finally {
      ref.read(loadingAllBookListProvider.notifier).update((state) => false);
    }
  }

  /// Retrieves a book using its ISBN.
  ///
  /// This method performs the following:
  /// - Sends a request to the API to fetch the book by ISBN using the
  ///   `apiIsbnBookNotifierProvider`.
  /// - Updates the `isbnBookRetrievedProvider` with the fetched book data.
  /// - Handles errors by logging them and updating the error state in
  ///   `apiIsbnBookNotifierProvider`.
  Future<void> getIsbnBook(String isbn) async {
    try {
      await ref.read(apiIsbnBookNotifierProvider.notifier).getBook(isbn);

      ref
          .read(isbnBookRetrievedProvider.notifier)
          .update((state) => ref.read(apiIsbnBookNotifierProvider).data!);

      log("Info del provider ${ref.read(apiIsbnBookNotifierProvider).success} ");
      log("Datos del libro encontrado");
    } on DioException catch (e) {
      log("Message: ${e.response?.data['message']}");
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiIsbnBookNotifierProvider.notifier).updateErrorRetrievingBook(
            message,
          );
    }
  }

  /// Saves a book to the user's collection.
  ///
  /// This method:
  /// - Updates the `loadingCreateBookProvider` to indicate the start of the request.
  /// - Reads the book data from the `isbnBookRetrievedProvider` and sends a
  ///   request to save the book using the `apiCreateBookNotifierProvider`.
  /// - Handles errors by logging them and updating the error state in
  ///   `apiCreateBookNotifierProvider`.
  /// - Updates the `loadingCreateBookProvider` to indicate the completion of
  ///   the operation.
  Future<void> saveBook() async {
    ref.read(loadingCreateBookProvider.notifier).update((state) => true);
    try {
      final book = ref.read(isbnBookRetrievedProvider);
      await ref.read(apiCreateBookNotifierProvider.notifier).createBook(book);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiCreateBookNotifierProvider.notifier)
          .updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref.read(loadingCreateBookProvider.notifier).update((state) => false);
    }
  }

  /// Retrieves detailed information for a specific book by its ID.
  ///
  /// This method communicates with the API to fetch detailed information
  /// about a book specified by the `bookId`. It manages the loading state
  /// and handles any errors encountered during the API call.
  ///
  /// **Parameters**:
  /// - `bookId`: The ID of the book to be retrieved.
  ///
  /// **Steps**:
  /// 1. Set `loadingShowBookProvider` to `true`.
  /// 2. Call the `showBook` method in the API provider.
  /// 3. Handle errors by updating the error state in the provider.
  /// 4. Reset `loadingShowBookProvider` to `false`.
  ///
  /// **Throws**:
  /// - [DioException]: If the API request fails.
  Future<void> showBook(String bookId) async {
    ref.read(loadingShowBookProvider.notifier).update((state) => true);
    try {
      await ref.read(apiShowBookNotifierProvider.notifier).showBook(bookId);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiShowBookNotifierProvider.notifier).updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref.read(loadingShowBookProvider.notifier).update((state) => false);
    }
  }

  /// Deactivates a specific book in the user's collection.
  ///
  /// This method sends a request to the API to deactivate a book by its ID.
  /// It manages the loading state and handles any errors encountered during
  /// the operation.
  ///
  /// **Parameters**:
  /// - `book`: The book object to be deactivated.
  ///
  /// **Throws**:
  /// - [DioException]: If the API request fails.
  Future<void> deactivateBook(Book book) async {
    ref.read(loadingDeactivateBookProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiDeactivateBookNotifierProvider.notifier)
          .deactivateBook(book.id);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiDeactivateBookNotifierProvider.notifier)
          .updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref.read(loadingDeactivateBookProvider.notifier).update((state) => false);
    }
  }

  /// Activates a specific book in the user's collection.
  ///
  /// This method sends a request to the API to activate a book by its ID.
  /// It manages the loading state and handles any errors encountered during
  /// the operation.
  ///
  /// **Parameters**:
  /// - `book`: The book object to be activated.
  ///
  /// **Throws**:
  /// - [DioException]: If the API request fails.
  Future<void> activateBook(Book book) async {
    ref.read(loadingActivateBookProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiActivateBookNotifierProvider.notifier)
          .activateBook(book.id);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiActivateBookNotifierProvider.notifier)
          .updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref.read(loadingActivateBookProvider.notifier).update((state) => false);
    }
  }

  /// Deactivates multiple books in the user's collection.
  ///
  /// This method sends a request to the API to deactivate multiple books
  /// specified by their IDs. It manages the loading state and handles
  /// any errors encountered during the operation.
  ///
  /// **Parameters**:
  /// - `booksId`: A list of IDs of the books to be deactivated.
  ///
  /// **Throws**:
  /// - [DioException]: If the API request fails.
  Future<void> deactivateBooks(List<String> booksId) async {
    ref.read(loadingDeactivateBooksProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiDeactivateBooksNotifierProvider.notifier)
          .deactivateBooks(booksId);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiDeactivateBooksNotifierProvider.notifier)
          .updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref
          .read(loadingDeactivateBooksProvider.notifier)
          .update((state) => false);
    }
  }

  /// Activates multiple books in the user's collection.
  ///
  /// This method sends a request to the API to activate multiple books
  /// specified by their IDs. It manages the loading state and handles
  /// any errors encountered during the operation.
  ///
  /// **Parameters**:
  /// - `booksId`: A list of IDs of the books to be activated.
  ///
  /// **Throws**:
  /// - [DioException]: If the API request fails.
  Future<void> activateBooks(List<String> booksId) async {
    ref.read(loadingActivateBooksProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiActivateBooksNotifierProvider.notifier)
          .activateBooks(booksId);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiActivateBooksNotifierProvider.notifier)
          .updateErrorOnBooksActions(
            message,
          );
    } finally {
      ref.read(loadingActivateBooksProvider.notifier).update((state) => false);
    }
  }
}
