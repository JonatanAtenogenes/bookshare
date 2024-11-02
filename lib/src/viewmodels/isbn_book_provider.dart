import 'dart:developer';

import 'package:bookshare/src/data/book_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

/// Provider for `ApiBookIsbnNotifier` to fetch book details by ISBN.
///
/// The `apiBookIsbnNotifierProvider` supplies an instance of `ApiBookIsbnNotifier`
/// with a `Dio` instance configured for API requests, including the
/// `TokenInterceptorInjector` for adding the authorization token to each request.
///
/// This provider uses `autoDispose` to release resources when the notifier
/// is no longer needed.
final apiBookIsbnNotifierProvider =
    StateNotifierProvider.autoDispose<ApiBookIsbnNotifier, Book>(
  (ref) {
    final dio = Dio(
      BaseOptions(contentType: 'application/json'),
    );

    // Adds token injection to the API requests via `TokenInterceptorInjector`.
    dio.interceptors.add(TokenInterceptorInjector());

    // Provides an `IsbnBookApiClient` instance to handle API requests for book details.
    return ApiBookIsbnNotifier(IsbnBookApiClient(dio));
  },
);

/// A `StateNotifier` responsible for fetching book information by ISBN.
///
/// The `ApiBookIsbnNotifier` class is designed to manage the retrieval of book
/// information based on the provided ISBN by interacting with the `IsbnBookApiClient`.
/// This notifier is used with Riverpod to manage and update the book data state
/// within the application.
class ApiBookIsbnNotifier extends StateNotifier<Book> {
  /// API client used to fetch book details by ISBN.
  final IsbnBookApiClient _isbnBookApiClient;

  /// Initializes the notifier with the specified `IsbnBookApiClient` instance.
  ///
  /// [isbnBookApiClient] - Client to perform API requests for book information.
  ApiBookIsbnNotifier(this._isbnBookApiClient) : super(Book.empty());

  /// Fetches book details by ISBN and updates the state with the book data.
  ///
  /// This method accepts an ISBN as a parameter, retrieves the book details
  /// via `_isbnBookApiClient`, and updates the state with the retrieved book.
  /// If an error occurs, it logs the error message and rethrows the exception
  /// for external handling.
  ///
  /// [isbn] - ISBN number used to identify the book.
  /// Returns a `Book` instance containing the book details if the request is successful.
  Future<Book> getBook(String isbn) async {
    log('Isbn: $isbn');
    try {
      final book = await _isbnBookApiClient.getIsbnBook(isbn);
      state = book;
      return book;
    } catch (e) {
      log('Error getting book information: $e');
      rethrow;
    }
  }
}
