import 'enum/exchange_attributes.dart';

class Exchange {
  String? _id;
  String? _offeringUserId;
  String? _receivingUserId;
  List<String>? _offeredBooksIds;
  List<String>? _offeringUserBooksIds;
  String? _exchangeAddress;
  DateTime? _exchangeDate;
  bool? _receivedExchange;
  String? _status;

  // Constructor
  Exchange({
    String? id,
    String? offeringUserId,
    String? receivingUserId,
    List<String>? offeredBooksIds,
    List<String>? offeringUserBooksIds,
    String? exchangeAddress,
    DateTime? exchangeDate,
    bool? receivedExchange,
    String? status,
  })  : _id = id,
        _offeringUserId = offeringUserId,
        _receivingUserId = receivingUserId,
        _offeredBooksIds = offeredBooksIds,
        _offeringUserBooksIds = offeringUserBooksIds,
        _exchangeAddress = exchangeAddress,
        _exchangeDate = exchangeDate,
        _receivedExchange = receivedExchange,
        _status = status;

  // Setters
  void setId(String id) {
    _id = id;
  }

  void setOfferingUserId(String userId) {
    _offeringUserId = userId;
  }

  void setReceivingUserId(String userId) {
    _receivingUserId = userId;
  }

  void setOfferedBooksIds(List<String> books) {
    _offeredBooksIds = books;
  }

  void setOfferingUserBooksIds(List<String> books) {
    _offeringUserBooksIds = books;
  }

  void setExchangeAddress(String address) {
    _exchangeAddress = address;
  }

  void setExchangeDate(DateTime date) {
    _exchangeDate = date;
  }

  void setReceivedExchange(bool received) {
    _receivedExchange = received;
  }

  void setStatus(String status) {
    _status = status;
  }

  // Getter for the exchange as a map
  Map<String, dynamic> get exchange {
    return {
      ExchangeAttributes.id.name: _id,
      ExchangeAttributes.offeringUserId.name: _offeringUserId,
      ExchangeAttributes.receivingUserId.name: _receivingUserId,
      ExchangeAttributes.offeredBooksIds.name: _offeredBooksIds,
      ExchangeAttributes.offeringUserBooksIds.name: _offeringUserBooksIds,
      ExchangeAttributes.exchangeAddress.name: _exchangeAddress,
      ExchangeAttributes.exchangeDate.name: _exchangeDate,
      ExchangeAttributes.receivedExchange.name: _receivedExchange,
      ExchangeAttributes.status.name: _status,
    };
  }
}
