import 'dart:developer';

import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/book/api_book_provider.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/book/api_isbn_book_provider.dart';
import '../view_models/user/user_provider.dart';

final bookDataProvider = StateProvider<BookData>((ref) {
  return BookData(ref);
});

class BookData {
  final Ref ref;

  BookData(this.ref);

  Future<void> getUserBooks() async {
    ref.read(loadingUserBookListProvider.notifier).update((state) => true);
    try {
      final userId = ref.read(currentUserProvider).id;

      await ref
          .read(apiUserBookListNotifierProvider.notifier)
          .retrieveUserBooks(userId);

      ref.read(userBooksProvider.notifier).update(
            (state) => ref.read(apiUserBookListNotifierProvider).data!,
          );

      log("\n----------------------");
      log("User Books ${ref.read(userBooksProvider)}");
    } on DioException catch (e) {
      // Handle any errors
      log('Error fetching user books: ${e.toString()}');
    } finally {
      ref.read(loadingUserBookListProvider.notifier).update((state) => false);
    }
  }

  Future<void> getIsbnBook(String isbn) async {
    try {
      //
      await ref.read(apiIsbnBookNotifierProvider.notifier).getBook(isbn);

      ref
          .read(isbnBookRetrievedProvider.notifier)
          .update((state) => ref.read(apiIsbnBookNotifierProvider).data!);

      log("Info del provider ${ref.read(apiIsbnBookNotifierProvider).success} ");
      log("datos del libro encontrado");
      //
    } on DioException catch (e) {
      //
      log("Message: ${e.response?.data['message']}");
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiIsbnBookNotifierProvider.notifier).updateErrorRetrievingBook(
            message,
          );
    }
  }

  Future<void> saveBook() async {
    ref.read(loadingCreateBookProvider.notifier).update((state) => true);
    try {
      //
      final book = ref.read(isbnBookRetrievedProvider);
      await ref.read(apiCreateBookNotifierProvider.notifier).createBook(book);
    } on DioException catch (e) {
      //
    } finally {
      ref.read(loadingCreateBookProvider.notifier).update((state) => false);
    }
  }
}
