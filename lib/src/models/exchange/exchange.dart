import '../enum/enums.dart';

/// Represents a book exchange between two users.
///
/// This class contains information about the exchange details, including
/// the IDs of the users involved, the list of book IDs offered and requested,
/// the address and date of the exchange, and its status.
class Exchange {
  final String id;
  final String offeringUserId;
  final String receivingUserId;
  final List<String> offeredBooksIds;
  final List<String> offeringUserBooksIds;
  final String exchangeAddress;
  final DateTime exchangeDate;
  final bool receivedExchange;
  final String status;

  /// Creates a new [Exchange] instance with the specified details.
  Exchange({
    required this.id,
    required this.offeringUserId,
    required this.receivingUserId,
    required this.offeredBooksIds,
    required this.offeringUserBooksIds,
    required this.exchangeAddress,
    required this.exchangeDate,
    required this.receivedExchange,
    required this.status,
  });

  /// Creates an empty [Exchange] instance with default values.
  factory Exchange.empty() {
    return Exchange(
      id: '',
      offeringUserId: '',
      receivingUserId: '',
      offeredBooksIds: [],
      offeringUserBooksIds: [],
      exchangeAddress: '',
      exchangeDate: DateTime.now(),
      receivedExchange: false,
      status: '',
    );
  }

  /// Creates an [Exchange] instance from a JSON object with a nested 'exchange' key.
  ///
  /// This expects a structure where all exchange-related fields are under
  /// the 'exchange' key, such as `json['exchange']['id']`.
  factory Exchange.fromJson(Map<String, dynamic> json) {
    String id = json['exchange'][ExchangeAttributes.id.name] ?? '';
    String offeringUserId =
        json['exchange'][ExchangeAttributes.offeringUserId.name] ?? '';
    String receivingUserId =
        json['exchange'][ExchangeAttributes.receivingUserId.name] ?? '';
    List<String> offeredBooksIds = List<String>.from(
        json['exchange'][ExchangeAttributes.offeredBooksIds.name] ?? []);
    List<String> offeringUserBooksIds = List<String>.from(
        json['exchange'][ExchangeAttributes.offeringUserBooksIds.name] ?? []);
    String exchangeAddress =
        json['exchange'][ExchangeAttributes.exchangeAddress.name] ?? '';
    DateTime exchangeDate = DateTime.tryParse(
            json['exchange'][ExchangeAttributes.exchangeDate.name]) ??
        DateTime.now();
    bool receivedExchange =
        json['exchange'][ExchangeAttributes.receivedExchange.name] ?? false;
    String status = json['exchange'][ExchangeAttributes.status.name] ?? '';

    return Exchange(
      id: id,
      offeringUserId: offeringUserId,
      receivingUserId: receivingUserId,
      offeredBooksIds: offeredBooksIds,
      offeringUserBooksIds: offeringUserBooksIds,
      exchangeAddress: exchangeAddress,
      exchangeDate: exchangeDate,
      receivedExchange: receivedExchange,
      status: status,
    );
  }

  /// Creates an [Exchange] instance from a JSON object without a nested 'exchange' key.
  ///
  /// This expects a flat structure where all exchange-related fields are
  /// at the root level, such as `json['id']`.
  factory Exchange.fromJsonWithoutKey(Map<String, dynamic> json) {
    String id = json['id'] ?? '';
    String offeringUserId = json['offeringUserId'] ?? '';
    String receivingUserId = json['receivingUserId'] ?? '';
    List<String> offeredBooksIds =
        List<String>.from(json['offeredBooksIds'] ?? []);
    List<String> offeringUserBooksIds =
        List<String>.from(json['offeringUserBooksIds'] ?? []);
    String exchangeAddress = json['exchangeAddress'] ?? '';
    DateTime exchangeDate =
        DateTime.tryParse(json['exchangeDate']) ?? DateTime.now();
    bool receivedExchange = json['receivedExchange'] ?? false;
    String status = json['status'] ?? '';

    return Exchange(
      id: id,
      offeringUserId: offeringUserId,
      receivingUserId: receivingUserId,
      offeredBooksIds: offeredBooksIds,
      offeringUserBooksIds: offeringUserBooksIds,
      exchangeAddress: exchangeAddress,
      exchangeDate: exchangeDate,
      receivedExchange: receivedExchange,
      status: status,
    );
  }

  /// Converts this [Exchange] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      ExchangeAttributes.id.name: id,
      ExchangeAttributes.offeringUserId.name: offeringUserId,
      ExchangeAttributes.receivingUserId.name: receivingUserId,
      ExchangeAttributes.offeredBooksIds.name: offeredBooksIds,
      ExchangeAttributes.offeringUserBooksIds.name: offeringUserBooksIds,
      ExchangeAttributes.exchangeAddress.name: exchangeAddress,
      ExchangeAttributes.exchangeDate.name: exchangeDate.toIso8601String(),
      ExchangeAttributes.receivedExchange.name: receivedExchange,
      ExchangeAttributes.status.name: status,
    };
  }

  /// Creates a copy of this [Exchange] instance with optional new values.
  Exchange copyWith({
    String? id,
    String? offeringUserId,
    String? receivingUserId,
    List<String>? offeredBooksIds,
    List<String>? offeringUserBooksIds,
    String? exchangeAddress,
    DateTime? exchangeDate,
    bool? receivedExchange,
    String? status,
  }) {
    return Exchange(
      id: id ?? this.id,
      offeringUserId: offeringUserId ?? this.offeringUserId,
      receivingUserId: receivingUserId ?? this.receivingUserId,
      offeredBooksIds: offeredBooksIds ?? this.offeredBooksIds,
      offeringUserBooksIds: offeringUserBooksIds ?? this.offeringUserBooksIds,
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
}
