import 'package:bookshare/src/data/book/book_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

class ApiBookNotifier extends StateNotifier<BookResponse> {
  final BookApiClient _bookApiClient;
  ApiBookNotifier(this._bookApiClient) : super(BookResponse.success(""));

  Future<void> showBook(String id) async {
    try {
      //
      final showBookResponse = await _bookApiClient.showBook(id);
      state = showBookResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> retrieveBooks(String userId) async {
    try {
      //
      final retrieveBooksResponse = await _bookApiClient.retrieveBooks(userId);
      state = retrieveBooksResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> retrieveUserBooks(String userId) async {
    try {
      //
      final retrieveUserBooksResponse = await _bookApiClient.retrieveUserBooks(userId);
      state = retrieveUserBooksResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> createBook(Book book) async {
    try {
      //
      final createBookResponse = await _bookApiClient.createBook(book);
      state = createBookResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> deactivateBook(String bookId) async {
    try {
      //
      final deactivateBookResponse = await _bookApiClient.deactivateBook(bookId);
      state = deactivateBookResponse;
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