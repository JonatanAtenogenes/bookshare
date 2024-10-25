import 'dart:developer';

import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/viewmodels/isbn_book_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddingBookScreen extends ConsumerStatefulWidget {
  const AddingBookScreen({super.key});

  @override
  ConsumerState<AddingBookScreen> createState() => _AddingBookScreenState();
}

class _AddingBookScreenState extends ConsumerState<AddingBookScreen> {
  final _isbnController = TextEditingController();
  final _valueController = TextEditingController();
  final _authorController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _isbnController.dispose();
    _valueController.dispose();
    _authorController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isbnApiProvider = ref.watch(isbnBooksApiProvider);
    _authorController.text = isbnApiProvider.authors.join(", ");
    _titleController.text = isbnApiProvider.title;

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
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.isbn,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: NumberTextField(
                        controller: _isbnController,
                        label: AppStrings.isbn,
                        maxLength: 13,
                        onSubmitted: (String isbn) {
                          log('isbn: $isbn');
                          ref.read(isbnBooksApiProvider.notifier).getBook(isbn);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.author,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(
                        label: AppStrings.author,
                        controller: _authorController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.book,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(
                        label: AppStrings.book,
                        controller: _titleController,
                      ),
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
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.bookValue,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: NumberTextField(
                        label: AppStrings.bookValue,
                        controller: _valueController,
                        maxLength: 3,
                      ),
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
