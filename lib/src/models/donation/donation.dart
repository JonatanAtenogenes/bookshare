import '../enum/enums.dart';

/// Represents a donation made by a user to a library, including book details, status, and confirmation.
///
/// This class provides methods to create a `Donation` instance from JSON api,
/// convert it to JSON, and copy or retrieve attributes.
class Donation {
  /// Unique identifier of the donation.
  final String id;

  /// ID of the user who made the donation.
  final String userId;

  /// ID of the library receiving the donation.
  final String libraryId;

  /// List of book IDs included in the donation.
  final List<String> booksIds;

  /// Status of the donation (e.g., pending, completed).
  final String status;

  /// Date when the donation was made.
  final DateTime donationDate;

  /// Indicates if the donation has been confirmed as received by the library.
  final bool receivedConfirmation;

  /// Constructs a `Donation` instance with the specified parameters.
  Donation({
    required this.id,
    required this.userId,
    required this.libraryId,
    required this.booksIds,
    required this.status,
    required this.donationDate,
    required this.receivedConfirmation,
  });

  /// Creates a copy of the current `Donation` instance with updated fields.
  ///
  /// If any parameter is omitted, the original value is retained.
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

  /// Retrieves the attributes of the `Donation` as a map.
  ///
  /// Useful for serialization or accessing the donation’s properties in a map format.
  Map<String, dynamic> get donation {
    return {
      DonationAttributes.id.name: id,
      DonationAttributes.userId.name: userId,
      DonationAttributes.libraryId.name: libraryId,
      DonationAttributes.booksIds.name: booksIds,
      DonationAttributes.status.name: status,
      DonationAttributes.donationDate.name: donationDate.toIso8601String(),
      DonationAttributes.receivedConfirmation.name: receivedConfirmation,
    };
  }

  /// Factory method to create a `Donation` instance from JSON api.
  ///
  /// This method expects a `Map<String, dynamic>` that contains the donation details.
  /// The donation attributes are accessed through a `donation` key in the JSON map.
  factory Donation.fromJson(Map<String, dynamic> json) {
    final donationData = json['donation'];

    final id = donationData[DonationAttributes.id.name] ?? '';
    final userId = donationData[DonationAttributes.userId.name] ?? '';
    final libraryId = donationData[DonationAttributes.libraryId.name] ?? '';
    final booksIds =
        List<String>.from(donationData[DonationAttributes.booksIds.name] ?? []);
    final status = donationData[DonationAttributes.status.name] ?? '';
    final donationDate = DateTime.parse(
        donationData[DonationAttributes.donationDate.name] ??
            DateTime.now().toIso8601String());
    final receivedConfirmation =
        donationData[DonationAttributes.receivedConfirmation.name] ?? false;

    return Donation(
      id: id,
      userId: userId,
      libraryId: libraryId,
      booksIds: booksIds,
      status: status,
      donationDate: donationDate,
      receivedConfirmation: receivedConfirmation,
    );
  }

  /// Factory method to create a `Donation` instance from JSON api without a key.
  ///
  /// This method assumes the JSON map directly contains the donation attributes,
  /// instead of being nested under a `donation` key.
  factory Donation.fromJsonWithoutKey(Map<String, dynamic> json) {
    final id = json[DonationAttributes.id.name] ?? '';
    final userId = json[DonationAttributes.userId.name] ?? '';
    final libraryId = json[DonationAttributes.libraryId.name] ?? '';
    final booksIds =
        List<String>.from(json[DonationAttributes.booksIds.name] ?? []);
    final status = json[DonationAttributes.status.name] ?? '';
    final donationDate = DateTime.parse(
        json[DonationAttributes.donationDate.name] ??
            DateTime.now().toIso8601String());
    final receivedConfirmation =
        json[DonationAttributes.receivedConfirmation.name] ?? false;

    return Donation(
      id: id,
      userId: userId,
      libraryId: libraryId,
      booksIds: booksIds,
      status: status,
      donationDate: donationDate,
      receivedConfirmation: receivedConfirmation,
    );
  }

  /// Converts the `Donation` instance into a JSON map.
  ///
  /// This method returns a map containing the donation attributes
  /// that can be used for serialization.
  Map<String, dynamic> toJson() {
    final id = this.id;
    final userId = this.userId;
    final libraryId = this.libraryId;
    final booksIds = this.booksIds;
    final status = this.status;
    final donationDate = this.donationDate.toIso8601String();
    final receivedConfirmation = this.receivedConfirmation;

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

  /// Factory method to create an empty `Donation` instance with default values.
  ///
  /// Useful for initializing an empty donation with placeholder api.
  factory Donation.empty() {
    return Donation(
      id: '',
      userId: '',
      libraryId: '',
      booksIds: [],
      status: '',
      donationDate: DateTime.now(),
      receivedConfirmation: false,
    );
  }
}
