import 'package:bookshare/src/api/exchange/exchange_api_client.dart';
import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/exchange_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/interceptors/token_interceptor.dart';

class ApiExchangeNotifier extends StateNotifier<ExchangeResponse> {
  final ExchangeApiClient _exchangeApiClient;
  ApiExchangeNotifier(this._exchangeApiClient)
      : super(ExchangeResponse.success(""));

  Future<void> createExchange(Exchange exchange) async {
    try {
      //
      final createExchangeResponse =
          await _exchangeApiClient.createExchange(exchange);
      state = createExchangeResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> updateExchange(Exchange exchange) async {
    try {
      //
      final updateExchangeResponse =
          await _exchangeApiClient.updateExchangeStatus(exchange.id, exchange);
      state = updateExchangeResponse;
    } catch (e) {
      //
      rethrow;
    }
  }

  void updateOnErrorExchange(String message) {
    state = ExchangeResponse.error(message);
  }
}

final apiCreateExchangeProvider =
    StateNotifierProvider<ApiExchangeNotifier, ExchangeResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiExchangeNotifier(ExchangeApiClient(dio));
});

final loadingCreateExchangeProvider = StateProvider<bool>((ref) => false);
