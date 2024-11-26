import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/data/user_data.dart';
import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/user/api_show_user_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/custom_cards.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getUserInformation();
    });
    super.initState();
  }

  Future<void> _getUserInformation() async {
    await ref.read(userDataProvider).getUserInformation();
    await ref.read(bookDataProvider).getSelectedUserBooks();
  }

  @override
  Widget build(BuildContext context) {
    final loadingInformation = ref.watch(loadingGetUserProvider);
    final loadingBooksInformation =
        ref.watch(loadingSelectedUserBookListProvider);
    final selectedUser = ref.watch(selectedUserProvider);
    final selectedUserBooks =
        ref.watch(apiSelectedUserBookListNotifierProvider).data;

    if (loadingInformation || loadingBooksInformation) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.appTitle,
          ),
        ),
        body: Skeletonizer(
          child: Column(
            children: [
              const TitleText(title: AppStrings.userProfile),
              const SubtitleText(subtitle: AppStrings.name),
              const Text(AppStrings.appBrand),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                height: 2,
                endIndent: 50,
                indent: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              const TitleText(title: "Libros del Usuario"),
              const SizedBox(
                height: 30,
              ),
              BookCard(
                book: Book.empty(),
                onTap: () {},
              ),
              BookCard(
                book: Book.empty(),
                onTap: () {},
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const TitleText(
                title: AppStrings.userProfile,
              ),
              Visibility(
                visible: selectedUser.name!.isNotEmpty,
                child: SubtitleText(subtitle: selectedUser.name!),
              ),
              Text(
                selectedUser.id.substring(8),
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                height: 2,
                endIndent: 50,
                indent: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              const TitleText(
                title: "Libros del Usuario",
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: selectedUserBooks != null,
                replacement: const Center(
                  child: Text("No se encontraron libros "),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.53,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedUserBooks!.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: selectedUserBooks[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
