import 'dart:developer';

import 'package:bookshare/src/view_models/exchange/api_exchange_list_provider.dart';
import 'package:bookshare/src/view_models/exchange/api_exchange_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_filter_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/exchange/exchange.dart';

/// A provider that exposes an instance of [ExchangeData] for managing exchange-related operations.
final exchangeDataProvider =
    StateProvider<ExchangeData>((ref) => ExchangeData(ref));

/// A class that manages exchange operations, including saving, updating,
/// fetching details, listing, and filtering exchanges.
///
/// This class interacts with various Riverpod providers to manage state
/// and API calls related to exchanges.
class ExchangeData {
  /// Reference to the Riverpod `Ref` for accessing providers.
  final Ref ref;

  /// Creates an instance of [ExchangeData] with the given [Ref].
  ExchangeData(this.ref);

  /// Saves a new exchange by calling the API and managing state updates.
  ///
  /// - Sets the loading state via [loadingCreateExchangeProvider].
  /// - Calls the [apiCreateExchangeProvider] to save the exchange.
  /// - Handles API errors using [DioException].
  /// - Resets the loading state after the operation.
  Future<void> saveExchange(Exchange exchange) async {
    ref.read(loadingCreateExchangeProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiCreateExchangeProvider.notifier)
          .createExchange(exchange);
    } on DioException catch (e) {
      log("Mensahe de error: ${e.response?.data['message']}");
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiCreateExchangeProvider.notifier)
          .updateOnErrorExchange(message);
    } finally {
      ref.read(loadingCreateExchangeProvider.notifier).update((state) => false);
    }
  }

  /// Updates an existing exchange by calling the API and managing state updates.
  ///
  /// - Sets the loading state via [loadingUpdateExchangeProvider].
  /// - Calls the [apiUpdateExchangeProvider] to update the exchange.
  /// - Handles API errors using [DioException].
  /// - Resets the loading state after the operation.
  Future<void> updateExchange(Exchange exchange) async {
    ref.read(loadingUpdateExchangeProvider.notifier).update((state) => true);
    try {
      await ref
          .read(apiUpdateExchangeProvider.notifier)
          .updateExchange(exchange);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiUpdateExchangeProvider.notifier)
          .updateOnErrorExchange(message);
    } finally {
      ref.read(loadingUpdateExchangeProvider.notifier).update((state) => false);
    }
  }

  /// Fetches the details of a specific exchange by calling the API and managing state updates.
  ///
  /// - Sets the loading state via [loadingShowExchangeProvider].
  /// - Calls the [apiShowExchangeProvider] to fetch exchange details.
  /// - Handles API errors using [DioException].
  /// - Resets the loading state after the operation.
  Future<void> showExchange(Exchange exchange) async {
    ref.read(loadingShowExchangeProvider.notifier).update((state) => true);
    try {
      await ref.read(apiShowExchangeProvider.notifier).showExchange(exchange);
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiShowExchangeProvider.notifier).updateOnErrorExchange(message);
    } finally {
      ref.read(loadingShowExchangeProvider.notifier).update((state) => false);
    }
  }

  /// Lists all exchanges for a specific user and applies filtering.
  ///
  /// - Sets the loading state via [loadingListExchangesProvider].
  /// - Calls the [apiListExchangesProvider] to retrieve the list of exchanges.
  /// - Updates the [userExchangesProvider] with the retrieved data.
  /// - Filters exchanges into separate providers for "accepted", "pending",
  ///   and "rejected/cancelled" statuses using the respective filter providers.
  /// - Handles API errors using [DioException].
  /// - Resets the loading state after the operation.
  Future<void> listExchanges(String userId) async {
    ref.read(loadingListExchangesProvider.notifier).update((state) => true);
    try {
      await ref.read(apiListExchangesProvider.notifier).listExchanges(userId);

      // Update user exchanges data.
      ref
          .read(userExchangesProvider.notifier)
          .update((state) => ref.read(apiListExchangesProvider).data!);

      // Apply filters to categorize exchanges.
      ref
          .read(exchangeFilterAcceptedProvider.notifier)
          .filterAccepted(ref.read(userExchangesProvider));
      ref.read(exchangeFilterPendingProvider.notifier).filterPending(
          ref.read(userExchangesProvider), ref.read(currentUserProvider));
      // ref
      //     .read(exchangeFilterRejectedProvider.notifier)
      //     .filterRejectedOrCancelled();
    } on DioException catch (e) {
      log("List error message: ${e.response?.data['message']}");
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiListExchangesProvider.notifier)
          .updateOnErrorListExchanges(message);
    } finally {
      ref.read(loadingListExchangesProvider.notifier).update((state) => false);
    }
  }
}
