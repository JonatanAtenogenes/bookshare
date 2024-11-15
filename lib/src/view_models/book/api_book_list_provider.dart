import 'package:bookshare/src/data/book/book_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiBookListNotifier extends StateNotifier<BookListResponse> {
  final BookApiClient _bookApiClient;

  ApiBookListNotifier(this._bookApiClient)
      : super(BookListResponse.success(""));

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
      final retrieveUserBooksResponse =
          await _bookApiClient.retrieveUserBooks(userId);
      state = retrieveUserBooksResponse;
    } catch (e) {
      //
      rethrow;
    }
  }
}

final apiAllBookListNotifierProvider =
    StateNotifierProvider<ApiBookListNotifier, BookListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookListNotifier(BookApiClient(dio));
});

final loadingAllBookListProvider = StateProvider<bool>((state) => false);

final apiUserBookListNotifierProvider =
    StateNotifierProvider<ApiBookListNotifier, BookListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiBookListNotifier(BookApiClient(dio));
});

final loadingUserBookListProvider = StateProvider<bool>((state) => false);
