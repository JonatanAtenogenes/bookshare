import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_models/book/api_book_list_provider.dart';

class ExchangeScreen extends ConsumerWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBooksList = ref.watch(apiUserBookListNotifierProvider).data;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SubtitleText(subtitle: AppStrings.availableExchanges),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5.5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userBooksList!.length,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {},
                  book: userBooksList[index],
                );
              },
            ),
          ),
          const SubtitleText(subtitle: AppStrings.realizedExchanges),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userBooksList.length,
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
