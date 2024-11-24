import 'dart:developer';

import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/book/isbn_book_api_client.dart';
import '../../api/interceptors/token_interceptor.dart';

class ApiIsbnBookNotifier extends StateNotifier<BookResponse> {
  /// API client used to fetch book details by ISBN.
  final IsbnBookApiClient _isbnBookApiClient;
  ApiIsbnBookNotifier(this._isbnBookApiClient) : super(BookResponse.error(""));
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

  void updateErrorRetrievingBook(String message) {
    state = BookResponse.error(message);
  }
}

final apiIsbnBookNotifierProvider =
    StateNotifierProvider.autoDispose<ApiIsbnBookNotifier, BookResponse>((ref) {
  final dio = Dio(
    BaseOptions(contentType: 'application/json'),
  );
  dio.interceptors.add(TokenInterceptorInjector());
  // dio.interceptors.addAll(List.of([
  //   TokenInterceptorInjector(),
  //   LogInterceptor(
  //     error: true,
  //     responseBody: true,
  //   ),
  // ]));
  return ApiIsbnBookNotifier(IsbnBookApiClient(dio));
});
