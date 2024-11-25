import 'dart:developer';

import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/book/isbn_book_api_client.dart';
import '../../api/interceptors/token_interceptor.dart';

/// A state notifier for managing book information retrieved via ISBN.
///
/// The `ApiIsbnBookNotifier` interacts with the `IsbnBookApiClient` to fetch
/// book details from the API and manage the application state based on the
/// response. This class ensures state updates and handles errors for operations
/// involving retrieving book data by ISBN.
class ApiIsbnBookNotifier extends StateNotifier<BookResponse> {
  /// API client used to fetch book details by ISBN.
  final IsbnBookApiClient _isbnBookApiClient;

  /// Initializes the notifier with an API client and sets the initial state.
  ///
  /// The initial state is set to an error state with an empty message.
  ApiIsbnBookNotifier(this._isbnBookApiClient) : super(BookResponse.error(""));

  /// Fetches book information using the provided ISBN.
  ///
  /// This method:
  /// - Logs the provided ISBN for debugging purposes.
  /// - Sends a request to the API using the `IsbnBookApiClient`.
  /// - Updates the notifier's state with the fetched book data.
  /// - Logs any errors encountered and rethrows them for higher-level handling.
  ///
  /// Throws:
  /// - Any exceptions that occur during the API request.
  Future<void> getBook(String isbn) async {
    log('Isbn: $isbn');
    try {
      final bookResponse = await _isbnBookApiClient.getIsbnBook(isbn);
      log('Book response ${bookResponse.data.toString()}');
      state = bookResponse;
    } catch (e) {
      log('Error getting book information: $e');
      rethrow;
    }
  }

  /// Updates the state to reflect an error with the provided message.
  ///
  /// This method is used when an error occurs while fetching book data,
  /// allowing the application to handle and display appropriate error messages.
  void updateErrorRetrievingBook(String message) {
    state = BookResponse.error(message);
  }
}

/// Provides an auto-disposable state notifier for managing book retrieval by ISBN.
///
/// The `apiIsbnBookNotifierProvider` creates and disposes of an
/// `ApiIsbnBookNotifier` instance as needed. It initializes the `IsbnBookApiClient`
/// with a configured Dio instance, which includes a `TokenInterceptorInjector`
/// for token-based API authentication.
final apiIsbnBookNotifierProvider =
    StateNotifierProvider.autoDispose<ApiIsbnBookNotifier, BookResponse>((ref) {
  final dio = Dio(
    BaseOptions(contentType: 'application/json'),
  );
  dio.interceptors.add(TokenInterceptorInjector());

  return ApiIsbnBookNotifier(IsbnBookApiClient(dio));
});
