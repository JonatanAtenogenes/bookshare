import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookInformation extends ConsumerWidget {
  const BookInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(simpleBookProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.bookInformation),
        ),
        body: Column(
          children: [
            TitleText(
              title: book.book[BookAttributes.title.name],
            ),
            Text(book.book[BookAttributes.authors.name].join(", "))
          ],
        ),
      ),
    );
  }
}
