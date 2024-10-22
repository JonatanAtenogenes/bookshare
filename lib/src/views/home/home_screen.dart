import 'dart:developer';

import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/temp/temp_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/book_card.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:bookshare/src/views/donations/library_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SubtitleText(
            subtitle: AppStrings.availableBooks,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.85,
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
          const SubtitleText(
            subtitle: AppStrings.libraries,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: libraries.length,
              itemBuilder: (context, index) {
                return LibraryCard(
                  library: libraries[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
