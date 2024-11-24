import 'dart:developer';
import 'dart:ffi';

import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/models/delegate/search_delegate.dart';
import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/view_models/book/api_book_provider.dart';
import 'package:bookshare/src/view_models/book/api_isbn_book_provider.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  final _conditionController = TextEditingController();

  @override
  void dispose() {
    _isbnController.dispose();
    _valueController.dispose();
    _authorController.dispose();
    _titleController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isbnBookProvider = ref.watch(isbnBookRetrievedProvider);
    final isbnNotifierProvider = ref.watch(apiIsbnBookNotifierProvider);
    final loadingCreationBookProvider = ref.watch(loadingCreateBookProvider);
    final apiCreateBookProvider = ref.watch(apiCreateBookNotifierProvider);

    if (isbnNotifierProvider.success) {
      _titleController.text = isbnBookProvider.title;
      _authorController.text = isbnBookProvider.authors.join(",");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SubtitleText(
                subtitle: AppStrings.searchBook,
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
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !isbnNotifierProvider.success &&
                    isbnNotifierProvider.message.isNotEmpty,
                child: ErrorText(text: isbnNotifierProvider.message),
              ),
              CustomButton(
                onPressed: () async {
                  log("ISBN ${_isbnController.text}");
                  await ref.read(bookDataProvider).getIsbnBook(
                        _isbnController.text,
                      );
                },
                text: AppStrings.searchBook,
              ),
              const Divider(
                height: 20,
                indent: 20,
                endIndent: 20,
              ),
              Visibility(
                visible: isbnNotifierProvider.success,
                child: Column(
                  children: [
                    Text(isbnBookProvider.toString()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          child: Image.network(
                            isbnBookProvider.image,
                            loadingBuilder: (context, child, loadingProgress) =>
                                const Center(
                                    child: CircularProgressIndicator()),
                            errorBuilder: (context, error, stack) {
                              return Image.asset(AssetsAccess.defaultBookImage);
                            },
                          ),
                        ),
                      ),
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
                              horizontal:
                                  MediaQuery.of(context).size.height / 25,
                              vertical: MediaQuery.of(context).size.width / 25,
                            ),
                            child: DropdownMenu(
                              controller: _conditionController,
                              onSelected: (BookCondition? condition) {
                                if (condition == null) return;
                                ref
                                    .read(isbnBookRetrievedProvider.notifier)
                                    .update(
                                      (state) => state.copyWith(
                                        condition: condition.value,
                                      ),
                                    );
                              },
                              dropdownMenuEntries: BookCondition.values
                                  .map<DropdownMenuEntry<BookCondition>>(
                                (BookCondition condition) {
                                  return DropdownMenuEntry(
                                    value: condition,
                                    label: condition.name,
                                  );
                                },
                              ).toList(),
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
                            maxLength: 4,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !loadingCreationBookProvider,
                      replacement: const LoadingButton(),
                      child: CustomButton(
                        onPressed: () async {
                          ref.read(isbnBookRetrievedProvider.notifier).update(
                                (state) => state.copyWith(
                                  user: ref.read(currentUserProvider),
                                  value: int.parse(_valueController.text),
                                ),
                              );
                          await ref.read(bookDataProvider).saveBook();

                          if (!ref
                              .read(apiCreateBookNotifierProvider)
                              .success) {
                            return;
                          }

                          ref.read(bookDataProvider).getUserBooks();

                          WidgetsBinding.instance
                              .addPostFrameCallback((callback) {
                            if (mounted) {
                              context.pop();
                            }
                          });
                        },
                        text: AppStrings.bookRegistration,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
