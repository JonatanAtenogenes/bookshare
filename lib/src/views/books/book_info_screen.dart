import 'package:bookshare/src/models/delegate/search_delegate.dart';
import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class BookInformation extends ConsumerWidget {
  const BookInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookInformation = ref.watch(bookInfoProvider);
    final userProvider = ref.watch(currentUserProvider);
    final sessionExchanges = ref.watch(sessionExchangesProvider);
    const duration = 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookInformation),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubtitleText(
                    subtitle: bookInformation.book[BookAttributes.title.name],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    bookInformation.image,
                    errorBuilder: (context, error, stackTrace) => const Image(
                      image: AssetImage(AssetsAccess.defaultBookImage),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SubtitleText(
                  subtitle: bookInformation.book[BookAttributes.authors.name]
                      .join(", "),
                ),
              ),
              Visibility(
                visible: bookInformation.synopsis.length > 180,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    bookInformation.synopsis,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(),
                  ),
                ),
              ),
              Text(
                'Valor: ${bookInformation.value}',
                style: GoogleFonts.lato(
                  fontSize: 22,
                ),
              ),
              Text(
                'Condicion: ${BookCondition.getNameByValue(bookInformation.condition)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Visibility(
                visible: userProvider.id != bookInformation.user.id,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Usuario: ",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                          ),
                        ),
                        TextLink(
                          text: bookInformation.user.id.substring(12),
                          onTap: () {
                            context.pushNamed(
                              RouteNames.userProfileScreenRoute,
                            );
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !ref
                          .read(sessionExchangesProvider.notifier)
                          .userInExchange(bookInformation),
                      replacement: Visibility(
                        visible: !ref
                            .read(sessionExchangesProvider.notifier)
                            .offeringBookExist(bookInformation),
                        replacement: CustomButton(
                          onPressed: () {
                            final bookRemoved = ref
                                .read(sessionExchangesProvider.notifier)
                                .removeFromOfferedBooks(bookInformation);

                            final message = bookRemoved
                                ? "Libro eliminado correctamente"
                                : "Error";
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
                          text: "Eliminar del Intercambio",
                        ),
                        child: CustomButton(
                          onPressed: () {
                            final bookAdded = ref
                                .read(sessionExchangesProvider.notifier)
                                .addingToOfferedBooks(bookInformation);

                            final message = bookAdded
                                ? "Libro agregado correctamente"
                                : "Error: El libro ya existe";

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
                          text: "Agregar a Intercambio",
                        ),
                      ),
                      child: CustomButton(
                        onPressed: () {
                          bool exchangeCreated = ref
                              .read(sessionExchangesProvider.notifier)
                              .createExchange(bookInformation);
                          String message = exchangeCreated
                              ? "Intercambio iniciado correctamente"
                              : "Ya existe un intercambio con el usuario";
                          toastification.show(
                            context: context,
                            title: Text(message),
                            type: exchangeCreated
                                ? ToastificationType.success
                                : ToastificationType.error,
                            style: ToastificationStyle.flat,
                            autoCloseDuration: const Duration(
                              seconds: duration,
                            ),
                          );
                        },
                        text: "Proponer Intercambio",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
