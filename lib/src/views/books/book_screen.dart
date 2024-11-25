import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/book/book.dart';
import '../../routes/route_names.dart';
import '../../view_models/book/book_provider.dart';

class BookScreen extends ConsumerStatefulWidget {
  const BookScreen({super.key});

  @override
  ConsumerState<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends ConsumerState<BookScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingUserBookListProvider);
    final booksList = ref.watch(userBooksProvider);

    if (loading) {
      return Skeletonizer(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return BookCard(
                book: Book.empty(),
                onTap: () {},
              );
            }),
      );
    }

    if (booksList.isEmpty) {
      return const Center(
        child: Text('Sin libros'),
      );
    }

    return const SuccessfulRetrievedBooks();
  }
}

class SuccessfulRetrievedBooks extends ConsumerWidget {
  const SuccessfulRetrievedBooks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksList = ref.watch(userBooksProvider);
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
              itemCount: booksList.length < 20 ? booksList.length : 20,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {
                    ref.read(bookInfoProvider.notifier).update(
                          (state) => booksList[index],
                        ),
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
