import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/data/exchange_data.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../utils/app_strings.dart';
import '../common/widgets/custom_cards.dart';

class ExchangeInformationScreen extends ConsumerWidget {
  const ExchangeInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exchange = ref.watch(currentExchangeInformation);
    final currentUser = ref.watch(currentUserProvider);
    final userIdentifier = (exchange.offeringUser.name != null &&
            exchange.offeringUser.name!.isNotEmpty)
        ? exchange.offeringUser.name!
        : exchange.offeringUser.id.isNotEmpty
            ? exchange.offeringUser.id.substring(10)
            : "Desconocido";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SubtitleText(
              subtitle: "Intercambio",
            ),
            Text(
              "Usuario: $userIdentifier",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Valor: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeredBooks)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Valor Alcanzado: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeringUserBooks)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Fecha del Intercambio: ${DateFormat('dd-MM-yyyy HH:mm').format(exchange.exchangeDate)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextLink(
              text: "Direccion del Intercambio",
              onTap: () =>
                  context.pushNamed(RouteNames.locationVisualizerScreen),
            ),
            const Text(
              "Libros seleccionados",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Visibility(
                visible: exchange.offeredBooks.isNotEmpty,
                replacement: const Center(
                  child: Text("No hay libros seleccionados"),
                ),
                child: ListView.builder(
                  itemCount: exchange.offeredBooks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BookCard(
                      book: exchange.offeredBooks[index],
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
            const Text(
              "Libros a intercambiar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Visibility(
                visible: exchange.offeringUserBooks.isNotEmpty,
                replacement: const Center(
                  child: Text("Agrega libros al intercambio"),
                ),
                child: ListView.builder(
                  itemCount: exchange.offeringUserBooks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BookCard(
                      book: exchange.offeringUserBooks[index],
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: exchange.receivingUser.id == currentUser.id &&
                  exchange.status != SwapStatus.rejected.name &&
                  exchange.status != SwapStatus.cancelled.name &&
                  exchange.exchangeDate.isBefore(DateTime.now()),
              child: CustomButton(
                onPressed: () async {
                  // Books are becoming active
                  await ref
                      .read(bookDataProvider)
                      .activateBooks(exchange.offeredBooks);
                  await ref
                      .read(bookDataProvider)
                      .activateBooks(exchange.offeringUserBooks);

                  // Exchange update to set cancelled state
                  await ref.read(exchangeDataProvider).updateExchange(
                      ref.read(currentExchangeInformation).copyWith(
                            status: SwapStatus.cancelled.name,
                          ));

                  // Update the current information
                  ref.read(currentExchangeInformation.notifier).update(
                        (state) =>
                            state.copyWith(status: SwapStatus.cancelled.name),
                      );

                  // Update the book data
                  ref.read(bookDataProvider).getUserBooks();
                  ref.read(bookDataProvider).getBooks();
                  ref
                      .read(exchangeDataProvider)
                      .listExchanges(ref.read(currentUserProvider).id);
                },
                text: "Cancelar Intercambio",
              ),
            ),
            Visibility(
              visible: exchange.receivingUser.id != currentUser.id,
              child: Visibility(
                visible: exchange.status == SwapStatus.pending.name,
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () async {
                        // Exchange update to set cancelled state
                        await ref.read(exchangeDataProvider).updateExchange(
                            ref.read(currentExchangeInformation).copyWith(
                                  status: SwapStatus.accepted.name,
                                ));

                        // Update the current information
                        ref.read(currentExchangeInformation.notifier).update(
                              (state) => state.copyWith(
                                  status: SwapStatus.accepted.name),
                            );

                        // Update the book data
                        ref.read(bookDataProvider).getUserBooks();
                        ref.read(bookDataProvider).getBooks();
                        ref
                            .read(exchangeDataProvider)
                            .listExchanges(ref.read(currentUserProvider).id);
                      },
                      text: "Aceptar Intercambio",
                    ),
                    CustomButton(
                      onPressed: () async {
                        // Books are becoming active
                        await ref
                            .read(bookDataProvider)
                            .activateBooks(exchange.offeredBooks);
                        await ref
                            .read(bookDataProvider)
                            .activateBooks(exchange.offeringUserBooks);

                        // Exchange update to set cancelled state
                        await ref.read(exchangeDataProvider).updateExchange(
                            ref.read(currentExchangeInformation).copyWith(
                                  status: SwapStatus.rejected.name,
                                ));

                        // Update the current information
                        ref.read(currentExchangeInformation.notifier).update(
                              (state) => state.copyWith(
                                  status: SwapStatus.rejected.name),
                            );

                        // Update the book data
                        ref.read(bookDataProvider).getUserBooks();
                        ref.read(bookDataProvider).getBooks();
                        ref
                            .read(exchangeDataProvider)
                            .listExchanges(ref.read(currentUserProvider).id);
                      },
                      text: "Rechazar Intercambio",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
