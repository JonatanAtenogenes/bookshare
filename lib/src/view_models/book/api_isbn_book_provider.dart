import 'dart:developer';

import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/book/isbn_book_api_client.dart';
import '../../data/interceptors/token_interceptor.dart';
import '../../models/book/book.dart';
import '../../models/response/book_response.dart';

class ApiIsbnBookNotifier extends StateNotifier<BookResponse> {
  /// API client used to fetch book details by ISBN.
  final IsbnBookApiClient _isbnBookApiClient;
  ApiIsbnBookNotifier(this._isbnBookApiClient) : super(BookResponse.error(""));
  Future<void> getBook(String isbn) async {
    log('Isbn: $isbn');
    try {
      final bookResponse = await _isbnBookApiClient.getIsbnBook(isbn);
      state = bookResponse;
    } catch (e) {
      log('Error getting book information: $e');
      rethrow;
    }
  }
}

final apiIsbnBookNotifierProvider =
StateNotifierProvider.autoDispose<ApiIsbnBookNotifier, BookResponse>(
      (ref) {
    final dio = Dio(
      BaseOptions(contentType: 'application/json'),
    );
    dio.interceptors.add(TokenInterceptorInjector());
    return ApiIsbnBookNotifier(IsbnBookApiClient(dio));
  }
);