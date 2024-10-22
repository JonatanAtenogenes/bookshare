import 'enum/enums.dart';

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

  // Constructor
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

  // CopyWith
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

  // Getter for the exchange as a map
  Map<String, dynamic> get exchange {
    return {
      ExchangeAttributes.id.name: id,
      ExchangeAttributes.offeringUserId.name: offeringUserId,
      ExchangeAttributes.receivingUserId.name: receivingUserId,
      ExchangeAttributes.offeredBooksIds.name: offeredBooksIds,
      ExchangeAttributes.offeringUserBooksIds.name: offeringUserBooksIds,
      ExchangeAttributes.exchangeAddress.name: exchangeAddress,
      ExchangeAttributes.exchangeDate.name: exchangeDate,
      ExchangeAttributes.receivedExchange.name: receivedExchange,
      ExchangeAttributes.status.name: status,
    };
  }
}
