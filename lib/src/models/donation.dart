import 'enum/enums.dart';

class Donation {
  final String id;
  final String userId;
  final String libraryId;
  final List<String> booksIds;
  final String status;
  final DateTime donationDate;
  final bool receivedConfirmation;

  // Constructor
  Donation({
    required this.id,
    required this.userId,
    required this.libraryId,
    required this.booksIds,
    required this.status,
    required this.donationDate,
    required this.receivedConfirmation,
  });

  // CopyWith
  Donation copyWith({
    String? id,
    String? userId,
    String? libraryId,
    List<String>? booksIds,
    String? status,
    DateTime? donationDate,
    bool? receivedConfirmation,
  }) {
    return Donation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      libraryId: libraryId ?? this.libraryId,
      booksIds: booksIds ?? this.booksIds,
      status: status ?? this.status,
      donationDate: donationDate ?? this.donationDate,
      receivedConfirmation: receivedConfirmation ?? this.receivedConfirmation,
    );
  }

  // Getter for the donation as a map
  Map<String, dynamic> get donation {
    return {
      DonationAttributes.id.name: id,
      DonationAttributes.userId.name: userId,
      DonationAttributes.libraryId.name: libraryId,
      DonationAttributes.booksIds.name: booksIds,
      DonationAttributes.status.name: status,
      DonationAttributes.donationDate.name: donationDate,
      DonationAttributes.receivedConfirmation.name: receivedConfirmation,
    };
  }
}
