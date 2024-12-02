import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionExchangesNotifier extends StateNotifier<List<Exchange>> {
  SessionExchangesNotifier(this.ref) : super([]);

  final Ref ref;

  /// Check if the current user is part of an exchange involving the provided book
  bool userInExchange(Book book) {
    if (state.isEmpty) return false;
    return state.any((exchange) => exchange.offeringUser.id == book.user.id);
  }

  /// Create a new exchange
  bool createExchange(Book book) {
    if (state.isNotEmpty &&
        state.any((exchange) => exchange.offeringUser.id == book.user.id)) {
      return false; // Avoid duplicate exchanges with the same user
    }

    User offeringUser = book.user;
    User receivingUser = ref.read(currentUserProvider);
    Exchange exchange = Exchange.empty().copyWith(
      offeringUser: offeringUser,
      receivingUser: receivingUser,
      offeredBooks: [book],
      exchangeAddress: "dshbjds",
    );

    // Update the global state
    state = [...state, exchange];

    // Update the current session exchange information
    ref.read(currentSessionExchangeInformation.notifier).state = exchange;

    return true;
  }

  /// Add a book to the offeredBooks list of an existing exchange
  bool addingToOfferedBooks(Book book) {
    final index = state.indexWhere(
      (exchange) => exchange.offeringUser.id == book.user.id,
    );

    if (index == -1 || offeringBookExist(book)) return false;

    final existingExchange = state[index];
    final updatedExchange = existingExchange.copyWith(
      offeredBooks: [...existingExchange.offeredBooks, book],
    );

    // Update the global state
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedExchange else state[i]
    ];

    // Update the current session exchange information
    ref.read(currentSessionExchangeInformation.notifier).state =
        updatedExchange;

    return true;
  }

  /// Remove a book from the offeredBooks list of an existing exchange
  bool removeFromOfferedBooks(Book book) {
    final index = state.indexWhere(
      (exchange) => exchange.offeringUser.id == book.user.id,
    );

    if (index == -1) return false;

    final existingExchange = state[index];
    final updatedBooks =
        existingExchange.offeredBooks.where((b) => b.id != book.id).toList();

    if (updatedBooks.length == existingExchange.offeredBooks.length) {
      return false; // Book not found
    }

    final updatedExchange = existingExchange.copyWith(
      offeredBooks: updatedBooks,
    );

    // Update the global state
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedExchange else state[i]
    ];

    // Update the current session exchange information
    ref.read(currentSessionExchangeInformation.notifier).state =
        updatedExchange;

    return true;
  }

  /// Check if a book is already in the offeredBooks list of any exchange
  bool offeringBookExist(Book book) {
    return state.any(
      (exchange) => exchange.offeredBooks.any(
        (offeredBook) => offeredBook.id == book.id,
      ),
    );
  }

  /// Add a book to the offeringUserBooks list of an existing exchange
  bool addingToOfferedUserBooks(User exchangeUser, Book book) {
    final index = state.indexWhere(
      (exchange) => exchange.offeringUser.id == exchangeUser.id,
    );

    if (index == -1 || offeringUserBookExist(book)) return false;

    final existingExchange = state[index];
    final updatedExchange = existingExchange.copyWith(
      offeringUserBooks: [...existingExchange.offeringUserBooks, book],
    );

    // Update the global state
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedExchange else state[i]
    ];

    // Update the current session exchange information
    ref.read(currentSessionExchangeInformation.notifier).state =
        updatedExchange;

    return true;
  }

  /// Remove a book from the offeringUserBooks list of an existing exchange
  bool removeFromOfferedUserBooks(User exchangeUser, Book book) {
    final index = state.indexWhere(
      (exchange) => exchange.offeringUser.id == exchangeUser.id,
    );

    if (index == -1) return false;

    final existingExchange = state[index];
    final updatedBooks = existingExchange.offeringUserBooks
        .where((b) => b.id != book.id)
        .toList();

    if (updatedBooks.length == existingExchange.offeringUserBooks.length) {
      return false; // Book not found
    }

    final updatedExchange = existingExchange.copyWith(
      offeringUserBooks: updatedBooks,
    );

    // Update the global state
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedExchange else state[i]
    ];

    // Update the current session exchange information
    ref.read(currentSessionExchangeInformation.notifier).state =
        updatedExchange;

    return true;
  }

  /// Check if a book is already in the offeringUserBooks list of any exchange
  bool offeringUserBookExist(Book book) {
    return state.any(
      (exchange) => exchange.offeringUserBooks.any(
        (offeredBook) => offeredBook.id == book.id,
      ),
    );
  }

  double valueOfUserBooks(List<Book> books) {
    if (books.isEmpty) return 0;
    double value = 0;
    books.forEach((book) => value += book.value);
    return value;
  }

  /// Remove an exchange based on the user ID
  bool removeExchange(User user) {
    // Find the index of the exchange where the offeringUser has the given userId
    final index =
        state.indexWhere((exchange) => exchange.offeringUser.id == user.id);

    if (index == -1) {
      return false; // Exchange not found
    }

    // Remove the exchange from the state
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];

    // Clear the current session exchange information if it matches the removed exchange
    final currentExchange =
        ref.read(currentSessionExchangeInformation.notifier).state;
    if (currentExchange.offeringUser.id == user.id) {
      ref.read(currentSessionExchangeInformation.notifier).state =
          Exchange.empty();
    }

    return true;
  }

  /// Reset all exchanges
  void reset() {
    state = List.empty();
    ref.read(currentSessionExchangeInformation.notifier).state =
        Exchange.empty();
  }
}

/// Provider for managing the list of session exchanges
final sessionExchangesProvider =
    StateNotifierProvider<SessionExchangesNotifier, List<Exchange>>((ref) {
  return SessionExchangesNotifier(ref);
});

/// Provider for managing the current exchange session
final currentSessionExchangeInformation = StateProvider<Exchange>(
  (ref) => Exchange.empty(),
);

final userExchangesProvider = StateProvider<List<Exchange>>(
  (ref) => List.empty(),
);
