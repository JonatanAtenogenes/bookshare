import 'dart:developer';

import 'package:bookshare/src/data/book_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enum/enums.dart';
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
            id: BookAttributes.id.name,
            isbn: BookAttributes.isbn.name,
            title: BookAttributes.title.name,
            authors: [],
            image: BookAttributes.image.name,
            userId: BookAttributes.userId.name,
            synopsis: BookAttributes.synopsis.name,
            publisher: BookAttributes.publisher.name,
            condition: 0,
            value: 0,
          ),
        );

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
