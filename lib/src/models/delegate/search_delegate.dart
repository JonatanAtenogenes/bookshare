import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_names.dart';
import '../../view_models/book/book_provider.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Book> bookList;
  final WidgetRef ref;

  CustomSearchDelegate(this.bookList, this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // This method is responsible for building actions in the AppBar,
    // such as a clear button.
    return [
      IconButton(
        onPressed: () => {query = ''},
        icon: const FaIcon(FontAwesomeIcons.xmark),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // The buildLeading method defines the leading icon or button.
    return IconButton(
      onPressed: () => {
        context.pop(),
      },
      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This method is responsible for displaying the search results.
    final List<Book> searchResult = bookList
        .where((book) => book.book[BookAttributes.title.name]
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.15,
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {
                    ref
                        .read(bookInfoProvider.notifier)
                        .update((state) => bookList[index]),
                    context.pushNamed(RouteNames.bookInformationScreenRoute),
                  },
                  book: searchResult[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // The buildSuggestions method is used to provide search suggestions as the user types.
    final List<Book> suggestionList = query.isEmpty
        ? []
        : bookList
            .where(
              (book) =>
                  book.book[BookAttributes.title.name].toLowerCase().contains(
                        query.toLowerCase(),
                      ),
            )
            .toList();
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.15,
            child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return BookCard(
                  onTap: () => {
                    ref.read(bookInfoProvider.notifier).update(
                          (state) => bookList[index],
                        ),
                    context.pushNamed(RouteNames.bookInformationScreenRoute),
                  },
                  book: suggestionList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
