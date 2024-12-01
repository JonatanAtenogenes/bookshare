import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/custom_cards.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../view_models/book/book_provider.dart';

class ExchangeRegisterScreen extends ConsumerWidget {
  const ExchangeRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentExchange = ref.watch(currentSessionExchangeInformation);
    final userBooks = ref.watch(userBooksProvider);
    final loadingSelectedBooks = ref.watch(loadingSelectedUserBookListProvider);
    final selectedUserBooks = ref.watch(selectedUserBooksProvider);
    const duration = 3;

    Future<void> getSelectedUserBooks() async {
      await ref.read(bookDataProvider).getSelectedUserBooks();
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
              const SubtitleText(
                subtitle: AppStrings.exchanges,
              ),
              const Text("User: ${8}"),
              const Text("Libros seleccionados"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Visibility(
                  visible: currentExchange.offeredBooks.isNotEmpty,
                  replacement: const Center(
                    child: Text("No hay libros seleccionados"),
                  ),
                  child: ListView.builder(
                    itemCount: currentExchange.offeredBooks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: currentExchange.offeredBooks[index],
                        onTap: () {
                          final bookRemoved = ref
                              .read(sessionExchangesProvider.notifier)
                              .removeFromOfferedBooks(
                                currentExchange.offeredBooks[index],
                              );
                          final message = bookRemoved
                              ? "Libro eliminado correctamente"
                              : "El libro no se pudo eliminar";
                          toastification.show(
                            context: context,
                            title: Text(message),
                            type: bookRemoved
                                ? ToastificationType.success
                                : ToastificationType.error,
                            style: ToastificationStyle.flat,
                            autoCloseDuration: const Duration(
                              seconds: duration,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                onPressed: () {
                  getSelectedUserBooks();
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SubtitleText(
                                subtitle: 'Libros del usuario a intercambiar',
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.36,
                                child: Visibility(
                                  visible: !loadingSelectedBooks,
                                  replacement: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ListView.builder(
                                    itemCount: selectedUserBooks.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return BookCard(
                                        book: selectedUserBooks[index],
                                        onTap: () {
                                          final bookAdded = ref
                                              .read(sessionExchangesProvider
                                                  .notifier)
                                              .addingToOfferedBooks(
                                                selectedUserBooks[index],
                                              );
                                          final message = bookAdded
                                              ? "Libro agregado correctamente"
                                              : "El libro ya existe en el intercambio";
                                          toastification.show(
                                            context: context,
                                            title: Text(message),
                                            type: bookAdded
                                                ? ToastificationType.success
                                                : ToastificationType.error,
                                            style: ToastificationStyle.flat,
                                            autoCloseDuration: const Duration(
                                              seconds: duration,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                text: "Agregar Libros",
              ),
              const Text("Libros a intercambiar"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Visibility(
                  visible: currentExchange.offeringUserBooks.isNotEmpty,
                  replacement: const Center(
                    child: Text("Agrega libros al intercambio"),
                  ),
                  child: ListView.builder(
                    itemCount: currentExchange.offeringUserBooks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: currentExchange.offeringUserBooks[index],
                        onTap: () {
                          final bookRemoved = ref
                              .read(sessionExchangesProvider.notifier)
                              .removeFromOfferedUserBooks(
                                currentExchange.offeringUser,
                                currentExchange.offeringUserBooks[index],
                              );
                          final message = bookRemoved
                              ? "Libro eliminado correctamente"
                              : "El libro no se pudo eliminar";
                          toastification.show(
                            context: context,
                            title: Text(message),
                            type: bookRemoved
                                ? ToastificationType.success
                                : ToastificationType.error,
                            style: ToastificationStyle.flat,
                            autoCloseDuration: const Duration(
                              seconds: duration,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SubtitleText(
                                  subtitle: 'Libros del usuario'),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.36,
                                child: ListView.builder(
                                  itemCount: userBooks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BookCard(
                                      book: userBooks[index],
                                      onTap: () {
                                        final bookAdded = ref
                                            .read(sessionExchangesProvider
                                                .notifier)
                                            .addingToOfferedUserBooks(
                                              currentExchange.offeringUser,
                                              userBooks[index],
                                            );
                                        final message = bookAdded
                                            ? "Libro agregado correctamente"
                                            : "El libro ya existe en el intercambio";
                                        toastification.show(
                                          context: context,
                                          title: Text(message),
                                          type: bookAdded
                                              ? ToastificationType.success
                                              : ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          autoCloseDuration: const Duration(
                                            seconds: duration,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                text: "Agregar Libros",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
