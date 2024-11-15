import 'dart:developer';

import 'package:bookshare/src/models/temp/temp_data.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookScreen extends ConsumerStatefulWidget {
  const BookScreen({super.key});

  @override
  ConsumerState<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends ConsumerState<BookScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      retrieveUserBooks();
    });
    super.initState();
  }

  Future<void> retrieveUserBooks() async {
    ref.read(loadingUserBookListProvider.notifier).update((state) => true);

    try {
      //
      final userId = ref.read(currentUserProvider).id;

      await ref
          .read(apiUserBookListNotifierProvider.notifier)
          .retrieveUserBooks(userId);

      log('-----------------------------------------------');
      log('${ref.read(apiUserBookListNotifierProvider).data}');
      log('-----------------------------------------------');
    } catch (e) {
      //
      log("Error getting user books ${e.toString()}");
    } finally {
      ref.read(loadingUserBookListProvider.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBooks = ref.watch(apiUserBookListNotifierProvider);
    if (!userBooks.success) {
      return const Text('Error');
    }

    if (userBooks.data!.isEmpty) {
      return Center(child: Text(userBooks.message));
    }

    return const SuccessfulRetrievedBooks();
  }
}

class SuccessfulRetrievedBooks extends ConsumerWidget {
  const SuccessfulRetrievedBooks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBooksList = ref.watch(apiUserBookListNotifierProvider).data;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SubtitleText(
            subtitle: AppStrings.booksInMyCollection,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userBooksList!.length < 20 ? userBooksList.length : 20,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {},
                  book: userBooksList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
