import 'enum/donation_attributes.dart';

class Donation {
  String? _id;
  String? _userId;
  String? _libraryId;
  List<String>? _booksIds;
  String? _status;
  DateTime? _donationDate;
  bool? _receivedConfirmation;

  // Constructor
  Donation({
    String? id,
    String? userId,
    String? libraryId,
    List<String>? booksIds,
    String? status,
    DateTime? donationDate,
    bool? receivedConfirmation,
  })  : _id = id,
        _userId = userId,
        _libraryId = libraryId,
        _booksIds = booksIds,
        _status = status,
        _donationDate = donationDate,
        _receivedConfirmation = receivedConfirmation;

  // Setters
  void setId(String id) {
    _id = id;
  }

  void setUserId(String userId) {
    _userId = userId;
  }

  void setLibraryId(String libraryId) {
    _libraryId = libraryId;
  }

  void setBooksIds(List<String> booksIds) {
    _booksIds = booksIds;
  }

  void setStatus(String status) {
    _status = status;
  }

  void setDonationDAte(DateTime donationDate) {
    _donationDate = donationDate;
  }

  void setReceivedConfirmation(bool receivedConfirmation) {
    _receivedConfirmation = receivedConfirmation;
  }

  // Getter for the donation as a map
  Map<String, dynamic> get donation {
    return {
      DonationAttributes.id.name: _id,
      DonationAttributes.userId.name: _userId,
      DonationAttributes.libraryId.name: _libraryId,
      DonationAttributes.booksIds.name: _booksIds,
      DonationAttributes.status.name: _status,
      DonationAttributes.donationDate.name: _donationDate,
      DonationAttributes.receivedConfirmation.name: _receivedConfirmation,
    };
  }
}
