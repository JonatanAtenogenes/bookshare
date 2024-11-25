import 'package:bookshare/src/api/book/book_api_client.dart';
import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

/// A state notifier for managing API interactions related to books.
///
/// The `ApiBookNotifier` class provides methods for handling book-related
/// operations, including fetching a book's details, creating a new book,
/// and deactivating a book. It updates the state based on the response
/// received from the `BookApiClient`.
class ApiBookNotifier extends StateNotifier<BookResponse> {
  /// API client used to interact with book-related endpoints.
  final BookApiClient _bookApiClient;

  /// Initializes the notifier with the specified API client.
  ///
  /// The initial state is set to a successful state with an empty message.
  ApiBookNotifier(this._bookApiClient) : super(BookResponse.success(""));

  /// Fetches details of a specific book by its ID.
  ///
  /// This method calls the `showBook` endpoint and updates the state
  /// with the response data. If an error occurs, it rethrows the exception
  /// for external handling.
  Future<void> showBook(String id) async {
    try {
      final showBookResponse = await _bookApiClient.showBook(id);
      state = showBookResponse;
    } catch (e) {
      rethrow;
    }
  }

  /// Creates a new book using the provided book details.
  ///
  /// This method sends a request to the `createBook` endpoint and updates
  /// the state with the response. If an error occurs, it rethrows the exception
  /// for external handling.
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

  /// Deactivates a book by its ID.
  ///
  /// This method sends a request to the `deactivateBook` endpoint and updates
  /// the state with the response. If an error occurs, it rethrows the exception
  /// for external handling.
  Future<void> deactivateBook(String bookId) async {
    try {
      final deactivateBookResponse =
          await _bookApiClient.deactivateBook(bookId);
      state = deactivateBookResponse;
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the state to reflect an error during book-related actions.
  ///
  /// This method is used to handle and display error messages when an error
  /// occurs during operations such as creating, fetching, or deactivating a book.
  void updateErrorOnBooksActions(String message) {
    state = BookResponse.error(message);
  }
}

/// Provides a state notifier for managing book-related actions via the API.
///
/// The `apiBookNotifierProvider` is a global provider that creates an
/// instance of `ApiBookNotifier` configured with a `BookApiClient` and
/// a `TokenInterceptorInjector` for secure API communication.
final apiBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Provides a state notifier for creating a new book.
///
/// The `apiCreateBookNotifierProvider` creates an instance of `ApiBookNotifier`
/// specifically for handling book creation requests. It is configured with
/// a `BookApiClient` and a `TokenInterceptorInjector`.
final apiCreateBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// A state provider to manage the loading state of book creation requests.
///
/// The `loadingCreateBookProvider` holds a boolean value indicating whether
/// a book creation operation is in progress. The default value is `false`.
final loadingCreateBookProvider = StateProvider<bool>((ref) => false);

/// Provides a state notifier for fetching details of a specific book.
///
/// The `apiShowBookNotifierProvider` creates an instance of `ApiBookNotifier`
/// for handling requests to fetch book details. It uses a `BookApiClient`
/// and a `TokenInterceptorInjector`.
final apiShowBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

/// Provides a state notifier for deactivating a book.
///
/// The `apiDeactivateBookNotifierProvider` creates an instance of `ApiBookNotifier`
/// for handling book deactivation requests. It is configured with a `BookApiClient`
/// and a `TokenInterceptorInjector`.
final apiDeactivateBookNotifierProvider =
    StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});
