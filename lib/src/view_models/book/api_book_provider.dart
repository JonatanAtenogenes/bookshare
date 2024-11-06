import 'package:bookshare/src/data/book/book_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

class ApiBookNotifier extends StateNotifier<BookResponse> {
  final BookApiClient _bookApiClient;
  ApiBookNotifier(this._bookApiClient) : super(BookResponse.success(""));

  Future<void> createBook(Book book) async {
    try {
      final createBookResponse = await _bookApiClient.createBook(book);
      state = createBookResponse;
    } catch (e) {
      //
      rethrow;
    }
  }
}

final apiBookNotifierProvider = StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});

final apiCreateBookNotifierProvider = StateNotifierProvider<ApiBookNotifier, BookResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookNotifier(BookApiClient(dio));
});