import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/book_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingAllBookListProvider);
    final booksList = ref.watch(listOfBooksProvider);

    //
    // if (!booksList.success) {
    //   return const Center(
    //     child: Text("Error"),
    //   );
    // }
    //
    // if (booksList.data!.isEmpty) {
    //   return Center(
    //     child: Text(booksList.message),
    //   );
    // }
    // if (booksList.isEmpty) {
    //   return const Center(
    //     child: Text('Sin libros'),
    //   );
    // }

    return const SuccessBookInfo();
  }
}

class SuccessBookInfo extends ConsumerWidget {
  const SuccessBookInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksList = ref.watch(listOfBooksProvider);
    final loading = ref.watch(loadingAllBookListProvider);
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(bookDataProvider).getBooks();
        },
        child: Skeletonizer(
          enabled: loading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SubtitleText(
                subtitle: AppStrings.availableBooks,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: booksList.length < 20 ? booksList.length : 20,
                  itemBuilder: (context, index) {
                    return BookCard(
                      onTap: () => {
                        ref.read(bookInfoProvider.notifier).update(
                              (state) => booksList[index],
                            ),
                        context
                            .pushNamed(RouteNames.bookInformationScreenRoute),
                      },
                      book: booksList[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
