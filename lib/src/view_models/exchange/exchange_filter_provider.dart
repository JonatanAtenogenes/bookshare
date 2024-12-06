import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';

/// A StateNotifier that manages and filters a list of exchanges based on their status.
class ExchangeFilterNotifier extends StateNotifier<List<Exchange>> {
  /// Constructs an [ExchangeFilterNotifier] that initially provides an empty list.
  ExchangeFilterNotifier() : super([]);

  /// Filters the list of exchanges by the "pending" status.
  /// This method now accepts a list of exchanges to filter.
  void filterPending(List<Exchange> exchanges, User user) {
    log("Tamaño de todos los intercambios: ${exchanges.length}");
    state = exchanges
        .where((exchange) =>
            exchange.status == "pending" && exchange.offeringUser.id == user.id)
        .toList();
  }

  /// Filters the list of exchanges by the "accepted" status.
  /// This method now accepts a list of exchanges to filter.
  void filterAccepted(List<Exchange> exchanges) {
    state =
        exchanges.where((exchange) => exchange.status == "accepted").toList();
  }

  /// Filters the list of exchanges by either "rejected" or "cancelled" statuses.
  /// This method now accepts a list of exchanges to filter.
  void filterRejectedOrCancelled(List<Exchange> exchanges) {
    state = exchanges
        .where((exchange) =>
            exchange.status == "rejected" || exchange.status == "cancelled")
        .toList();
  }

  /// Resets the state to an empty list.
  void resetFilter() {
    state = [];
  }
}

/// Provider for filtering exchanges with "accepted" status.
final exchangeFilterAcceptedProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  return ExchangeFilterNotifier(); // Initialize with an empty list.
});

/// Provider for filtering exchanges with "pending" status.
final exchangeFilterPendingProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  return ExchangeFilterNotifier(); // Initialize with an empty list.
});

/// Provider for filtering exchanges with "rejected" or "cancelled" status.
final exchangeFilterRejectedProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  return ExchangeFilterNotifier(); // Initialize with an empty list.
});
