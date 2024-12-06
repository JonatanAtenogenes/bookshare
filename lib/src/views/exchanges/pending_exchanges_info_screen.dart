import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/exchange/exchange_filter_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../common/widgets/custom_cards.dart';
import '../common/widgets/text_widgets.dart';

class PendingExchangesInfoScreen extends ConsumerWidget {
  const PendingExchangesInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userExchanges = ref.watch(exchangeFilterPendingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SubtitleText(subtitle: AppStrings.exchanges),
            const SizedBox(
              height: 35,
            ),
            Visibility(
              visible: userExchanges.isNotEmpty,
              replacement: const Center(
                child: Text("No hay intercambios"),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.71,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userExchanges.length,
                  itemBuilder: (context, index) {
                    return ExchangeCard(
                      exchange: userExchanges[index],
                      onTap: () {
                        ref
                            .read(currentExchangeInformation.notifier)
                            .update((state) => userExchanges[index]);
                        context.pushNamed(
                            RouteNames.exchangeInformationScreenRoute);
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
  }
}
