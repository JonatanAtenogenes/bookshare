import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:bookshare/src/views/common/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AddingBookScreen extends StatelessWidget {
  const AddingBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SubtitleText(
                  subtitle: AppStrings.bookRegistration,
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.isbn,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: NumberTextField(label: AppStrings.isbn),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.author,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(label: AppStrings.author),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.book,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(label: AppStrings.book),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.bookCondition,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height / 25,
                          vertical: MediaQuery.of(context).size.width / 25,
                        ),
                        child: DropdownMenu(
                          dropdownMenuEntries: BookCondition.values
                              .map<DropdownMenuEntry<BookCondition>>(
                                  (BookCondition condition) {
                            return DropdownMenuEntry(
                              value: condition,
                              label: condition.name,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.bookValue,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: NumberTextField(label: AppStrings.bookValue),
                    ),
                  ],
                ),
                CustomButton(onPressed: () => {}, text: AppStrings.accept)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
