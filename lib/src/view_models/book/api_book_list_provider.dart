import 'package:bookshare/src/api/book/book_api_client.dart';
import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier for managing API interactions related to lists of books.
///
/// The `ApiBookListNotifier` class provides methods for retrieving books from
/// the server. It supports fetching all books and books specific to a user.
/// The state is updated based on the response from the `BookApiClient`.
class ApiBookListNotifier extends StateNotifier<BookListResponse> {
  /// API client used to interact with book list endpoints.
  final BookApiClient _bookApiClient;

  /// Initializes the notifier with the specified API client.
  ///
  /// The initial state is set to a successful state with an empty message.
  ApiBookListNotifier(this._bookApiClient)
      : super(BookListResponse.success(""));

  /// Retrieves a list of all books from the server.
  ///
  /// This method sends a request to the `retrieveBooks` endpoint using the
  /// provided `userId` and updates the state with the response.
  Future<void> retrieveBooks(String userId) async {
    try {
      final retrieveBooksResponse = await _bookApiClient.retrieveBooks(userId);
      state = state.copyWith(
        success: retrieveBooksResponse.success,
        message: retrieveBooksResponse.message,
        data: retrieveBooksResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves a list of books specific to a user from the server.
  ///
  /// This method sends a request to the `retrieveUserBooks` endpoint using
  /// the provided `userId` and updates the state with the response.
  Future<void> retrieveUserBooks(String userId) async {
    try {
      final retrieveUserBooksResponse =
          await _bookApiClient.retrieveUserBooks(userId);
      state = state.copyWith(
        success: retrieveUserBooksResponse.success,
        message: retrieveUserBooksResponse.message,
        data: retrieveUserBooksResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the state to reflect an error during book list retrieval.
  ///
  /// This method is used to handle and display error messages when an error
  /// occurs during operations such as fetching all books or user-specific books.
  void updateErrorOnRetrievingBooks(String message) {
    state = BookListResponse.error(message);
  }
}

/// Provides a state notifier for managing the retrieval of all books.
///
/// The `apiAllBookListNotifierProvider` is a global provider that creates an
/// instance of `ApiBookListNotifier` configured with a `BookApiClient` and
/// a `TokenInterceptorInjector` for secure API communication.
final apiAllBookListNotifierProvider =
    StateNotifierProvider<ApiBookListNotifier, BookListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookListNotifier(BookApiClient(dio));
});

/// A state provider to manage the loading state of retrieving all books.
///
/// The `loadingAllBookListProvider` holds a boolean value indicating whether
/// a request to retrieve all books is in progress. The default value is `false`.
final loadingAllBookListProvider = StateProvider<bool>((state) => false);

/// Provides a state notifier for managing the retrieval of books for a specific user.
///
/// The `apiUserBookListNotifierProvider` creates an instance of `ApiBookListNotifier`
/// for handling requests to fetch books owned by a specific user. It uses a
/// `BookApiClient` and a `TokenInterceptorInjector`.
final apiUserBookListNotifierProvider =
    StateNotifierProvider<ApiBookListNotifier, BookListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookListNotifier(BookApiClient(dio));
});

/// A state provider to manage the loading state of retrieving user-specific books.
///
/// The `loadingUserBookListProvider` holds a boolean value indicating whether
/// a request to retrieve books for a specific user is in progress. The default value is `false`.
final loadingUserBookListProvider = StateProvider<bool>((state) => false);

final apiSelectedUserBookListNotifierProvider =
    StateNotifierProvider<ApiBookListNotifier, BookListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookListNotifier(BookApiClient(dio));
});

final loadingSelectedUserBookListProvider = StateProvider<bool>(
  (state) => false,
);
