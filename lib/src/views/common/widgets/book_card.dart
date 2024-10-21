import 'dart:developer';

import 'package:bookshare/src/models/temp/temp_classes.dart';
import 'package:bookshare/src/views/common/widgets/text_link.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.bookUser,
  });

  final BookUser bookUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          bookUser.getBookUser['uri'],
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bookUser.getBookUser['bookName'],
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        bookUser.getBookUser['author'],
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextLink(
                        text: bookUser.getBookUser['name'],
                        onTap: () => {
                          log('User: ${bookUser.getBookUser['name']}'),
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Valor'),
                      Text(bookUser.getBookUser['value'].toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
