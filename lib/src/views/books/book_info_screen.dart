import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookInformation extends ConsumerWidget {
  const BookInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookInformation),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleText(
                title: book.book[BookAttributes.title.name],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  book.image,
                  errorBuilder: (context, error, stackTrace) => const Image(
                    image: AssetImage(AssetsAccess.defaultBookImage),
                  ),
                ),
              ),
              SubtitleText(
                subtitle: book.book[BookAttributes.authors.name].join(", "),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  book.synopsis,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('Valor: ${book.value}'),
              Text('Condicion: ${BookCondition.getNameByValue(book.condition)}')
            ],
          ),
        ),
      ),
    );
  }
}
