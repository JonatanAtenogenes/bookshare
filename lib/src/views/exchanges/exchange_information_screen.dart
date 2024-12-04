import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_strings.dart';
import '../common/widgets/custom_cards.dart';

class ExchangeInformationScreen extends ConsumerWidget {
  const ExchangeInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exchange = ref.watch(currentExchangeInformation);
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
              "User: $userIdentifier",
            ),
            Text(
              "Valor: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeredBooks)}",
            ),
            Text(
              "Valor Alcanzado: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeringUserBooks)}",
            ),
            const Text("Libros seleccionados"),
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
            const Text("Libros a intercambiar"),
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
              visible: exchange.status == "pending",
              child: Column(
                children: [
                  CustomButton(onPressed: () {}, text: "Aceptar Intercambio"),
                  CustomButton(onPressed: () {}, text: "Rechazar Intercambio"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
