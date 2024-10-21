import 'package:bookshare/src/models/temp/temp_data.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/book_card.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:bookshare/src/views/donations/library_card.dart';
import 'package:flutter/material.dart';

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
                  bookUser: bookList[index],
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
