import 'dart:developer';

import 'package:bookshare/src/api/exchange/exchange_api_client.dart';
import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/exchange_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/interceptors/token_interceptor.dart';

/// A StateNotifier that handles the state and logic for managing exchanges.
///
/// This class interacts with the `ExchangeApiClient` to perform API requests
/// related to creating, updating, and retrieving exchanges. It updates the state
/// of the `ExchangeResponse` to reflect the success, message, and data returned
/// by the API.

class ApiExchangeNotifier extends StateNotifier<ExchangeResponse> {
  /// The API client used to perform exchange-related API operations.
  final ExchangeApiClient _exchangeApiClient;

  /// Constructs an [ApiExchangeNotifier] with the provided [ExchangeApiClient].
  ///
  /// The initial state of the notifier is set to a success response with an
  /// empty message.
  ApiExchangeNotifier(this._exchangeApiClient)
      : super(ExchangeResponse.success(""));

  /// Creates a new exchange by sending the provided [exchange] to the API.
  ///
  /// Updates the state with the response received from the API.
  ///
  /// **Parameters**:
  /// - `exchange`: The [Exchange] object containing the details of the new exchange.
  ///
  /// **Throws**:
  /// - Any exception encountered during the API request is rethrown for
  ///   higher-level error handling.
  Future<void> createExchange(Exchange exchange) async {
    try {
      final createExchangeResponse = await _exchangeApiClient.createExchange(
        exchange,
      );
      log("Elementos: ${createExchangeResponse.data}");
      state = state.copyWith(
        success: createExchangeResponse.success,
        message: createExchangeResponse.message,
        data: createExchangeResponse.data,
      );
    } catch (e) {
      log("Error al definir la creacion ${e.toString()}");
      rethrow;
    }
  }

  /// Updates an existing exchange by sending the updated [exchange] to the API.
  ///
  /// Updates the state with the response received from the API.
  ///
  /// **Parameters**:
  /// - `exchange`: The [Exchange] object containing the updated details of the exchange.
  ///
  /// **Throws**:
  /// - Any exception encountered during the API request is rethrown for
  ///   higher-level error handling.
  Future<void> updateExchange(Exchange exchange) async {
    try {
      final updateExchangeResponse =
          await _exchangeApiClient.updateExchange(exchange.id, exchange);
      state = state.copyWith(
        success: updateExchangeResponse.success,
        message: updateExchangeResponse.message,
        data: updateExchangeResponse.data,
      );
    } catch (e) {
      log("Error ${e}");
      rethrow;
    }
  }

  /// Retrieves the details of a specific exchange by sending its [exchange] object to the API.
  ///
  /// Updates the state with the response received from the API.
  ///
  /// **Parameters**:
  /// - `exchange`: The [Exchange] object containing the ID of the exchange to be retrieved.
  ///
  /// **Throws**:
  /// - Any exception encountered during the API request is rethrown for
  ///   higher-level error handling.
  Future<void> showExchange(Exchange exchange) async {
    try {
      final showExchangeResponse =
          await _exchangeApiClient.showExchange(exchange.id);
      state = state.copyWith(
        success: showExchangeResponse.success,
        message: showExchangeResponse.message,
        data: showExchangeResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the state with an error message for exchange-related operations.
  ///
  /// This method is used to set the state to an error response with the provided
  /// [message].
  ///
  /// **Parameters**:
  /// - `message`: The error message to be displayed in the response.
  void updateOnErrorExchange(String message) {
    state = ExchangeResponse.error(message);
  }
}

/// Provider for managing the creation of exchanges.
///
/// Uses an instance of [ApiExchangeNotifier] with the required `ExchangeApiClient`.
final apiCreateExchangeProvider =
    StateNotifierProvider<ApiExchangeNotifier, ExchangeResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.addAll(
    List.of([
      TokenInterceptorInjector(),
      LogInterceptor(
        responseBody: true,
      )
      // CleanResponseInterceptor(),
    ]),
  );
  // dio.interceptors.add(TokenInterceptorInjector());
  return ApiExchangeNotifier(ExchangeApiClient(dio));
});

/// Loading state provider for the exchange creation process.
///
/// Tracks whether the exchange creation operation is in progress.
final loadingCreateExchangeProvider = StateProvider<bool>((ref) => false);

/// Provider for managing the updating of exchanges.
///
/// Uses an instance of [ApiExchangeNotifier] with the required `ExchangeApiClient`.
final apiUpdateExchangeProvider =
    StateNotifierProvider<ApiExchangeNotifier, ExchangeResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiExchangeNotifier(ExchangeApiClient(dio));
});

/// Loading state provider for the exchange update process.
///
/// Tracks whether the exchange update operation is in progress.
final loadingUpdateExchangeProvider = StateProvider<bool>((ref) => false);

/// Provider for managing the retrieval of exchange details.
///
/// Uses an instance of [ApiExchangeNotifier] with the required `ExchangeApiClient`.
final apiShowExchangeProvider =
    StateNotifierProvider<ApiExchangeNotifier, ExchangeResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiExchangeNotifier(ExchangeApiClient(dio));
});

/// Loading state provider for the exchange retrieval process.
///
/// Tracks whether the exchange retrieval operation is in progress.
final loadingShowExchangeProvider = StateProvider<bool>((ref) => false);
