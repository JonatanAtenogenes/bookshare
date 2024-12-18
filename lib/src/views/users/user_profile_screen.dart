import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/data/user_data.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/user/api_show_user_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/custom_cards.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../routes/route_names.dart';
import '../../view_models/book/book_provider.dart';

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
    final selectedUserBooksApiStatus = ref.watch(
      apiSelectedUserBookListNotifierProvider,
    );

    final userIdentifier =
        (selectedUser.name != null && selectedUser.name!.isNotEmpty)
            ? selectedUser.name!
            : selectedUser.id.isNotEmpty
                ? selectedUser.id.substring(10)
                : "Desconocido";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Visibility(
            visible: selectedUserBooksApiStatus.success,
            replacement: const Center(
              child: TitleText(title: "Error"),
            ),
            child: Skeletonizer(
              enabled: loadingInformation || loadingBooksInformation,
              child: Column(
                children: [
                  const TitleText(
                    title: AppStrings.userProfile,
                  ),
                  SubtitleText(
                    subtitle: "Usuario: $userIdentifier",
                  ),
                  Text(
                    "Libros en coleccion: ${selectedUserBooks!.length}",
                    style: const TextStyle(
                      fontSize: 22,
                    ),
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
                    visible: selectedUserBooks.isNotEmpty,
                    replacement: const Center(
                      child: Text("No se encontraron libros "),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.53,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedUserBooks.length,
                        itemBuilder: (context, index) {
                          return BookCard(
                            book: selectedUserBooks[index],
                            onTap: () {
                              ref.read(bookInfoProvider.notifier).update(
                                    (state) => selectedUserBooks[index],
                                  );
                              context.pushNamed(
                                  RouteNames.bookInformationScreenRoute);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
