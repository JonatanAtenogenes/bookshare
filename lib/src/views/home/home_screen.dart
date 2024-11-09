import 'dart:developer';

import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/temp/temp_data.dart';
import 'package:bookshare/src/providers/content_provider.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _pullRefresh() async {
    Future.delayed(const Duration(seconds: 60));
    ref.read(loadingContentProvider.notifier).update((state) => state = true);
  }

  Future<void> _pullRefreshUpdate() async {
    Future.delayed(const Duration(seconds: 60));
    ref.read(loadingContentProvider.notifier).update((state) => state = false);
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingContentProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SubtitleText(
            subtitle: AppStrings.availableBooks,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Skeletonizer(
              enabled: loading,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: bookList.length,
                itemBuilder: (context, index) {
                  return BookCard(
                    onTap: () => {
                      log('Info book: ${bookList[index].book[BookAttributes.userId.name]}'),
                      context.pushNamed(RouteNames.bookInformationScreenRoute),
                    },
                    book: bookList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
BookCard(
                      onTap: () => {
                        log('Info book: ${bookList[index].book[BookAttributes.userId.name]}'),
                        context.pushNamed(RouteNames.bookInformationScreenRoute),
                      },
                      book: bookList[index],
                    );

                    */
