import 'package:bookshare/src/models/temp/temp_data.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/book_card.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:flutter/material.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SubtitleText(subtitle: AppStrings.availableExchanges),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
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
          const SubtitleText(subtitle: AppStrings.realizedExchanges),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
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
        ],
      ),
    );
  }
}
