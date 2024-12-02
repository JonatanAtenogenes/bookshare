import 'package:bookshare/src/api/exchange/exchange_api_client.dart';
import 'package:bookshare/src/models/response/exchange_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/interceptors/token_interceptor.dart';

/// A StateNotifier that manages the state and logic for listing exchanges.
///
/// This class interacts with the `ExchangeApiClient` to fetch a list of exchanges
/// associated with a specific user. It updates the state of the `ExchangeListResponse`
/// to reflect the success, message, and data returned by the API.
class ApiExchangeListNotifier extends StateNotifier<ExchangeListResponse> {
  /// The API client used to perform exchange-related API operations.
  final ExchangeApiClient _exchangeApiClient;

  /// Constructs an [ApiExchangeListNotifier] with the provided [ExchangeApiClient].
  ///
  /// The initial state of the notifier is set to a success response with an empty message.
  ApiExchangeListNotifier(this._exchangeApiClient)
      : super(ExchangeListResponse.success(""));

  /// Fetches a list of exchanges associated with the specified [userId].
  ///
  /// Updates the state with the response received from the API.
  ///
  /// **Parameters**:
  /// - `userId`: The ID of the user whose exchanges need to be listed.
  ///
  /// **Throws**:
  /// - Any exception encountered during the API request is rethrown for
  ///   higher-level error handling.
  Future<void> listExchanges(String userId) async {
    try {
      final listExchangesResponse =
          await _exchangeApiClient.listExchanges(userId);
      state = state.copyWith(
        success: listExchangesResponse.success,
        message: listExchangesResponse.message,
        data: listExchangesResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the state with an error message for listing exchanges.
  ///
  /// This method sets the state to an error response with the provided [message].
  ///
  /// **Parameters**:
  /// - `message`: The error message to be displayed in the response.
  void updateOnErrorListExchanges(String message) {
    state = ExchangeListResponse.error(message);
  }
}

/// Provider for managing the listing of exchanges.
///
/// Uses an instance of [ApiExchangeListNotifier] with the required `ExchangeApiClient`.
final apiListExchangesProvider =
    StateNotifierProvider<ApiExchangeListNotifier, ExchangeListResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiExchangeListNotifier(ExchangeApiClient(dio));
});

/// Loading state provider for the exchange listing process.
///
/// Tracks whether the exchange listing operation is in progress.
final loadingListExchangesProvider = StateProvider<bool>((ref) => false);
