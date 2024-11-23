import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/user/user_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      retrieveAllBooks();
    });
    super.initState();
  }

  Future<void> retrieveAllBooks() async {
    try {
      //
      ref.read(loadingAllBookListProvider.notifier).update((state) => true);

      final userId = ref.read(currentUserProvider).id;

      log('-----------------------------------------------');
      log(ref.read(currentUserProvider).id);
      log('-----------------------------------------------');

      await ref
          .read(apiAllBookListNotifierProvider.notifier)
          .retrieveBooks(userId);

      log('-----------------------------------------------');
      log('${ref.read(apiAllBookListNotifierProvider).data}');
      log('-----------------------------------------------');
    } catch (e) {
      //
      log("Error getting user books ${e.toString()}");
    } finally {
      ref.read(loadingAllBookListProvider.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingAllBookListProvider);
    final booksList = ref.watch(apiAllBookListNotifierProvider);

    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!booksList.success) {
      return const Center(
        child: Text("Error"),
      );
    }

    if (booksList.data!.isEmpty) {
      return Center(
        child: Text(booksList.message),
      );
    }

    return const SuccessBookInfo();
  }
}

class SuccessBookInfo extends ConsumerWidget {
  const SuccessBookInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksList = ref.watch(apiAllBookListNotifierProvider).data;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SubtitleText(
            subtitle: AppStrings.availableBooks,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: booksList!.length < 20 ? booksList.length : 20,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {
                    context.pushNamed(RouteNames.bookInformationScreenRoute),
                  },
                  book: booksList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
