import 'dart:developer';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    } on DioException catch (e) {
      // Handle any errors
      log('Error fetching user books: ${e.toString()}');
    } finally {
      ref.read(loadingUserBookListProvider.notifier).update((state) => false);
    }
  }
}
