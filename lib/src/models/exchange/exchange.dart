import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../book/book.dart';
import '../enum/enums.dart';
import '../user/user.dart';

/// Represents a book exchange between two users.
/// This class contains information about the exchange details, including
/// the users involved, the list of books offered and requested,
/// the address and date of the exchange, and its status.
class Exchange {
  final String id;
  final User offeringUser;
  final User receivingUser;
  final List<Book> offeredBooks;
  final List<Book> offeringUserBooks;
  final LatLng exchangeAddress;
  final DateTime exchangeDate;
  final bool receivedExchange;
  final String status;

  /// Creates a new [Exchange] instance with the specified details.
  Exchange({
    required this.id,
    required this.offeringUser,
    required this.receivingUser,
    required this.offeredBooks,
    required this.offeringUserBooks,
    required this.exchangeAddress,
    required this.exchangeDate,
    required this.receivedExchange,
    required this.status,
  });

  /// Creates an empty [Exchange] instance with default values.
  factory Exchange.empty() {
    return Exchange(
      id: '',
      offeringUser: User.empty(),
      receivingUser: User.empty(),
      offeredBooks: [],
      offeringUserBooks: [],
      exchangeAddress: const LatLng(19.28786, -99.65324),
      // Default address
      exchangeDate: DateTime.now(),
      receivedExchange: false,
      status: SwapStatus.pending.name,
    );
  }

  /// Creates an [Exchange] instance from a JSON object with a nested 'exchange' key.
  factory Exchange.fromJson(Map<String, dynamic> json) {
    return Exchange(
      id: json['exchange'][ExchangeAttributes.id.name] ?? '',
      offeringUser: User.fromJson(
          json['exchange'][ExchangeAttributes.offeringUser.name] ?? {}),
      receivingUser: User.fromJson(
          json['exchange'][ExchangeAttributes.receivingUser.name] ?? {}),
      offeredBooks:
          (json['exchange'][ExchangeAttributes.offeredBooks.name] ?? [])
              .map<Book>((bookJson) => Book.fromJson(bookJson))
              .toList(),
      offeringUserBooks:
          (json['exchange'][ExchangeAttributes.offeringUserBooks.name] ?? [])
              .map<Book>((bookJson) => Book.fromJson(bookJson))
              .toList(),
      exchangeAddress:
          json['exchange'][ExchangeAttributes.exchangeAddress.name] != null
              ? LatLng(
                  json['exchange'][ExchangeAttributes.exchangeAddress.name][0],
                  json['exchange'][ExchangeAttributes.exchangeAddress.name][1],
                )
              : LatLng(19.28786, -99.65324),
      // Default address
      exchangeDate: DateTime.tryParse(
              json['exchange'][ExchangeAttributes.exchangeDate.name]) ??
          DateTime.now(),
      receivedExchange:
          json['exchange'][ExchangeAttributes.receivedExchange.name] ?? false,
      status: json['exchange'][ExchangeAttributes.status.name] ?? '',
    );
  }

  /// Creates an [Exchange] instance from a JSON object without a nested 'exchange' key.
  factory Exchange.fromJsonWithoutKey(Map<String, dynamic> json) {
    return Exchange(
      id: json['id'] ?? '',
      offeringUser: User.fromJsonWithoutKey(json['offering_user'] ?? {}),
      receivingUser: User.fromJsonWithoutKey(json['receiving_user'] ?? {}),
      offeredBooks: (json['offered_books'] ?? [])
          .map<Book>((bookJson) => Book.fromJsonWithoutKey(bookJson))
          .toList(),
      offeringUserBooks: (json['offering_user_books'] ?? [])
          .map<Book>((bookJson) => Book.fromJsonWithoutKey(bookJson))
          .toList(),
      exchangeAddress: json['exchange_address'] != null
          ? LatLng(
              json['exchange_address'][0],
              json['exchange_address'][1],
            )
          : LatLng(19.28786, -99.65324),
      // Default address
      exchangeDate: DateTime.tryParse(json['exchange_date']) ?? DateTime.now(),
      receivedExchange: json['received_exchange'] ?? false,
      status: json['status'] ?? '',
    );
  }

  /// Converts this [Exchange] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      ExchangeAttributes.id.name: id,
      ExchangeAttributes.offeringUser.name: offeringUser.toJson(),
      ExchangeAttributes.receivingUser.name: receivingUser.toJson(),
      ExchangeAttributes.offeredBooks.name:
          offeredBooks.map((book) => book.toJson()).toList(),
      ExchangeAttributes.offeringUserBooks.name:
          offeringUserBooks.map((book) => book.toJson()).toList(),
      ExchangeAttributes.exchangeAddress.name: [
        exchangeAddress.latitude,
        exchangeAddress.longitude
      ],
      ExchangeAttributes.exchangeDate.name: exchangeDate.toIso8601String(),
      ExchangeAttributes.receivedExchange.name: receivedExchange,
      ExchangeAttributes.status.name: status,
    };
  }

  /// Creates a copy of this [Exchange] instance with optional new values.
  Exchange copyWith({
    String? id,
    User? offeringUser,
    User? receivingUser,
    List<Book>? offeredBooks,
    List<Book>? offeringUserBooks,
    LatLng? exchangeAddress,
    DateTime? exchangeDate,
    bool? receivedExchange,
    String? status,
  }) {
    return Exchange(
      id: id ?? this.id,
      offeringUser: offeringUser ?? this.offeringUser,
      receivingUser: receivingUser ?? this.receivingUser,
      offeredBooks: offeredBooks ?? this.offeredBooks,
      offeringUserBooks: offeringUserBooks ?? this.offeringUserBooks,
      exchangeAddress: exchangeAddress ?? this.exchangeAddress,
      exchangeDate: exchangeDate ?? this.exchangeDate,
      receivedExchange: receivedExchange ?? this.receivedExchange,
      status: status ?? this.status,
    );
  }

  /// Creates a list of [Exchange] instances from a list of JSON objects with a nested 'exchange' key.
  static List<Exchange> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Exchange.fromJson(json)).toList();
  }

  /// Creates a list of [Exchange] instances from a list of JSON objects without a nested 'exchange' key.
  static List<Exchange> fromJsonListWithoutKey(List<dynamic> jsonList) {
    return jsonList.map((json) => Exchange.fromJsonWithoutKey(json)).toList();
  }

  /// Converts the [Exchange] instance to a string representation.
  @override
  String toString() {
    return 'Exchange(id: $id, offeringUser: $offeringUser, receivingUser: $receivingUser, '
        'offeredBooks: $offeredBooks, offeringUserBooks: $offeringUserBooks, '
        'exchangeAddress: $exchangeAddress, exchangeDate: $exchangeDate, '
        'receivedExchange: $receivedExchange, status: $status)';
  }
}
