import 'package:bookshare/src/data/book_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/book/api_book_list_provider.dart';
import '../../view_models/exchange/exchange_filter_provider.dart';

class ExchangeScreen extends ConsumerWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBooksList = ref.watch(apiUserBookListNotifierProvider).data;
    final acceptedExchangeList = ref.watch(exchangeFilterAcceptedProvider);
    final sessionExchanges = ref.watch(sessionExchangesProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SubtitleText(subtitle: AppStrings.configureExchanges),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5.5,
            child: Visibility(
              visible: sessionExchanges.isNotEmpty,
              replacement: const Center(
                child: Text("No hay intercambios"),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sessionExchanges.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(sessionExchanges[index].offeringUser.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onDismissed: (direction) {
                      ref
                          .read(sessionExchangesProvider.notifier)
                          .removeExchange(sessionExchanges[index].offeringUser);
                    },
                    child: ExchangeCard(
                      onTap: () async {
                        ref
                            .read(currentSessionExchangeInformation.notifier)
                            .update((state) => sessionExchanges[index]);
                        ref.read(selectedUserProvider.notifier).update(
                            (state) => sessionExchanges[index].offeringUser);
                        ref.read(bookDataProvider).getSelectedUserBooks();
                        context.pushNamed(
                          RouteNames.exchangeRegisterScreenRoute,
                        );
                      },
                      exchange: sessionExchanges[index],
                    ),
                  );
                },
              ),
            ),
          ),
          const SubtitleText(subtitle: "Intercabios Aceptados"),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Visibility(
              visible: acceptedExchangeList.isNotEmpty,
              replacement: const Center(
                child: Text("No hay intercambios aceptados"),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: acceptedExchangeList.length,
                itemBuilder: (context, index) {
                  return ExchangeCard(
                    onTap: () => {},
                    exchange: acceptedExchangeList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
