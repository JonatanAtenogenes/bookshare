import 'dart:developer';

import 'package:bookshare/src/data/book_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

final isbnApiProvider = Provider<IsbnBookApiClient>((ref) {
  final dio = Dio();
  return IsbnBookApiClient(dio);
});

final isbnBooksApiProvider =
    StateNotifierProvider.autoDispose<IsbnBooksApiNotifier, Book>(
  (ref) => IsbnBooksApiNotifier(),
);

class IsbnBooksApiNotifier extends StateNotifier<Book> {
  final _isbnBookApiClient = IsbnBookApiClient(
    Dio(
      BaseOptions(contentType: 'application/json'),
    ),
  );

  IsbnBooksApiNotifier()
      : super(
          Book(
              id: "id",
              isbn: "ISBN",
              title: "Title",
              authors: [],
              synopsis: "Synopsis",
              image: "Image",
              publisher: "Publisher",
              userId: "userId",
              condition: 0,
              value: 0),
        );

  Future<Book> getBook(String isbn) async {
    log('Isbn: $isbn');
    try {
      final book = await _isbnBookApiClient.getIsbnBook(isbn);
      state = book;
      log('Book: $book');
      return book;
    } catch (e) {
      log('Error getting book information: $e');
      rethrow;
    }
  }
}
