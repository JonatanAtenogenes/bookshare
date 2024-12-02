import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookshare/src/models/exchange/exchange.dart';

/// A StateNotifier that manages and filters a list of exchanges based on their status.
class ExchangeFilterNotifier extends StateNotifier<List<Exchange>> {
  /// The full list of exchanges (unfiltered).
  final List<Exchange> _allExchanges;

  /// Constructs an [ExchangeFilterNotifier] with the initial list of exchanges.
  ///
  /// The [initialExchanges] represents the complete list of exchanges available
  /// before any filtering is applied.
  ExchangeFilterNotifier(this._allExchanges) : super(_allExchanges);

  /// Filters the list of exchanges by the "pending" status.
  ///
  /// This updates the state to include only exchanges where the status is `"pending"`.
  void filterPending() {
    state = _allExchanges
        .where((exchange) => exchange.status == "pending")
        .toList();
  }

  /// Filters the list of exchanges by the "accepted" status.
  ///
  /// This updates the state to include only exchanges where the status is `"accepted"`.
  void filterAccepted() {
    state = _allExchanges
        .where((exchange) => exchange.status == "accepted")
        .toList();
  }

  /// Filters the list of exchanges by either "rejected" or "cancelled" statuses.
  ///
  /// This updates the state to include only exchanges where the status is either
  /// `"rejected"` or `"cancelled"`.
  void filterRejectedOrCancelled() {
    state = _allExchanges
        .where((exchange) =>
            exchange.status == "rejected" || exchange.status == "cancelled")
        .toList();
  }

  /// Resets the state to the full list of exchanges.
  ///
  /// This clears any active filters and restores the state to contain
  /// the original unfiltered list of exchanges.
  void resetFilter() {
    state = _allExchanges;
  }
}

/// Provider for filtering exchanges with "accepted" status.
///
/// This provider uses [ExchangeFilterNotifier] to manage the list of exchanges
/// and allows filtering based on the "accepted" status.
final exchangeFilterAcceptedProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  final List<Exchange> initialExchanges =
      ref.read(userExchangesProvider); // Initialize with your data source.
  return ExchangeFilterNotifier(initialExchanges);
});

/// Provider for filtering exchanges with "pending" status.
///
/// This provider uses [ExchangeFilterNotifier] to manage the list of exchanges
/// and allows filtering based on the "pending" status.
final exchangeFilterPendingProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  final List<Exchange> initialExchanges =
      ref.read(userExchangesProvider); // Initialize with your data source.
  return ExchangeFilterNotifier(initialExchanges);
});

/// Provider for filtering exchanges with "rejected" or "cancelled" status.
///
/// This provider uses [ExchangeFilterNotifier] to manage the list of exchanges
/// and allows filtering based on the "rejected" or "cancelled" statuses.
final exchangeFilterRejectedProvider =
    StateNotifierProvider<ExchangeFilterNotifier, List<Exchange>>((ref) {
  final List<Exchange> initialExchanges =
      ref.read(userExchangesProvider); // Initialize with your data source.
  return ExchangeFilterNotifier(initialExchanges);
});
