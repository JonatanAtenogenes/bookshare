import 'package:bookshare/src/view_models/exchange/api_exchange_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/exchange/exchange.dart';

final exchangeDataProvider =
    StateProvider<ExchangeData>((ref) => ExchangeData(ref));

class ExchangeData {
  Ref ref;

  ExchangeData(this.ref);

  Future<void> saveExchange(Exchange exchange) async {
    ref.read(loadingCreateExchangeProvider.notifier).update((state) => true);
    try {
      //
      await ref
          .read(apiCreateExchangeProvider.notifier)
          .createExchange(exchange);

      // ref.read(userExchangesProvider.notifier).update((state));
    } on DioException catch (e) {
      //
      String message = "Error";
      ref
          .read(apiCreateExchangeProvider.notifier)
          .updateOnErrorExchange(message);
    } finally {
      //
      ref.read(loadingCreateExchangeProvider.notifier).update((state) => false);
    }
  }
}
