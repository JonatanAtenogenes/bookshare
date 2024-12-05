import 'package:bookshare/src/api/book/book_api_client.dart';
import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

/// A state notifier for managing book-related API interactions.
///
/// This class handles book-related actions such as retrieving details of a book,
/// creating new books, deactivating or activating individual books, and batch operations
/// (activating or deactivating multiple books). It uses [BookApiClient] for API communication
/// and updates the state based on the operation's result.
class ApiBookNotifier extends StateNotifier<BookResponse> {
  /// API client for interacting with book-related endpoints.
  final BookApiClient _bookApiClient;

  /// Initializes the notifier with the provided [BookApiClient].
  ///
  /// The initial state is set to a successful state with an empty message.
  ApiBookNotifier(this._bookApiClient) : super(BookResponse.success(""));

  /// Fetches the details of a specific book by its unique ID.
  ///
  /// - [id]: The unique identifier of the book to retrieve.
  ///
  /// Updates the state with the book details on success.
  /// If an error occurs, the exception is rethrown for external handling.
  Future<void> showBook(String id) async {
    try {
      final showBookResponse = await _bookApiClient.showBook(id);
      state = state.copyWith(
        success: showBookResponse.success,
        message: showBookResponse.message,
        data: showBookResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Creates a new book with the provided details.
  ///
  /// - [book]: An instance of [Book] containing the book's attributes.
  ///
  /// Updates the state with the response on success.
  /// If an error occurs, the exception is rethrown for external handling.
  Future<void> createBook(Book book) async {
    try {
      final createBookResponse = await _bookApiClient.createBook(book);
      state = state.copyWith(
        success: createBookResponse.success,
        message: createBookResponse.message,
        data: createBookResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Deactivates a book by its unique ID.
  ///
  /// - [bookId]: The unique identifier of the book to deactivate.
  ///
  /// Updates the state with the response on success.
  Future<void> deactivateBook(String bookId) async {
    try {
      final deactivateBookResponse =
          await _bookApiClient.deactivateBook(bookId);
      state = state.copyWith(
        success: deactivateBookResponse.success,
        message: deactivateBookResponse.message,
        data: deactivateBookResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Activates a book by its unique ID.
  ///
  /// - [bookId]: The unique identifier of the book to activate.
  ///
  /// Updates the state with the response on success.
  Future<void> activateBook(String bookId) async {
    try {
      final activateBookResponse = await _bookApiClient.activateBook(bookId);
      state = state.copyWith(
        success: activateBookResponse.success,
        message: activateBookResponse.message,
        data: activateBookResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Deactivates multiple books by their unique IDs.
  ///
  /// - [bookIds]: A list of unique identifiers of the books to deactivate.
  ///
  /// Updates the state with the response on success.
  Future<void> deactivateBooks(List<String> bookIds) async {
    try {
      final deactivatesBookResponse =
          await _bookApiClient.deactivateBooks(bookIds);
      state = state.copyWith(
        success: deactivatesBookResponse.success,
        message: deactivatesBookResponse.message,
        data: deactivatesBookResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Activates multiple books by their unique IDs.
  ///
  /// - [bookIds]: A list of unique identifiers of the books to activate.
  ///
  /// Updates the state with the response on success.
  Future<void> activateBooks(List<Book> books) async {
    try {
      final activateBooksResponse = await _bookApiClient.activateBooks(books);
      state = state.copyWith(
        success: activateBooksResponse.success,
        message: activateBooksResponse.message,
        data: activateBooksResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> areBooksActive(List<Book> books) async {
    try {
      final areBooksActiveResponse = await _bookApiClient.areBooksActive(books);
      state = state.copyWith(
        success: areBooksActiveResponse.success,
        message: areBooksActiveResponse.message,
        data: areBooksActiveResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the state to reflect an error.
  ///
  /// - [message]: The error message to set in the state.
  void updateErrorOnBooksActions(String message) {
    state = BookResponse.error(message);
  }
}

/// Providers for state management and API communication.

/// Global provider for managing book-related API actions.
final apiBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Provider for managing book creation actions.
final apiCreateBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of book creation operations.
final loadingCreateBookProvider = StateProvider<bool>((ref) => false);

/// Provider for fetching details of a specific book.
final apiShowBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of book details fetching.
final loadingShowBookProvider = StateProvider<bool>((ref) => false);

/// Provider for deactivating a book.
final apiDeactivateBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of book deactivation.
final loadingDeactivateBookProvider = StateProvider<bool>((ref) => false);

/// Provider for activating a book.
final apiActivateBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of book activation.
final loadingActivateBookProvider = StateProvider<bool>((ref) => false);

/// Provider for deactivating multiple books.
final apiDeactivateBooksNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of multiple books deactivation.
final loadingDeactivateBooksProvider = StateProvider<bool>((ref) => false);

/// Provider for activating multiple books.
final apiActivateBooksNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of multiple books activation.
final loadingActivateBooksProvider = StateProvider<bool>((ref) => false);

final apiAreBooksActiveNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Tracks the loading state of multiple books activation.
final loadingAreBooksActiveProvider = StateProvider<bool>((ref) => false);
