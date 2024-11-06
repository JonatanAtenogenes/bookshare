import '../enum/enums.dart';

/// Represents an address with details such as street, numbers, postal code,
/// locality, city, and state.
class Address {
  final String street;
  final String? interiorNumber;
  final String exteriorNumber;
  final String postalCode;
  final String locality;
  final String city;
  final String state;

  /// Creates a new [Address] instance with the specified details.
  Address({
    required this.street,
    this.interiorNumber,
    required this.exteriorNumber,
    required this.postalCode,
    required this.locality,
    required this.city,
    required this.state,
  });

  /// Creates a copy of this [Address] instance with optional new values.
  Address copyWith({
    String? street,
    String? interiorNumber,
    String? exteriorNumber,
    String? postalCode,
    String? locality,
    String? city,
    String? state,
  }) {
    return Address(
      street: street ?? this.street,
      interiorNumber: interiorNumber,
      exteriorNumber: exteriorNumber ?? this.exteriorNumber,
      postalCode: postalCode ?? this.postalCode,
      locality: locality ?? this.locality,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }

  /// Creates an [Address] instance from a JSON object with a nested 'address' key.
  ///
  /// This expects a structure where all address-related fields are under
  /// the 'address' key, such as `json['address']['street']`.
  factory Address.fromJson(Map<String, dynamic> json) {
    String street = json['address']['street'] ?? "";
    String interiorNumber = json['address']['interiorNumber'] ?? "";
    String exteriorNumber = json['address']['exteriorNumber'] ?? "";
    String postalCode = json['address']['postalCode'] ?? "";
    String locality = json['address']['locality'] ?? "";
    String city = json['address']['city'] ?? "";
    String state = json['address']['state'] ?? "";

    return Address(
      street: street,
      interiorNumber: interiorNumber,
      exteriorNumber: exteriorNumber,
      postalCode: postalCode,
      locality: locality,
      city: city,
      state: state,
    );
  }

  /// Creates an [Address] instance from a JSON object without a nested key.
  ///
  /// This expects a flat structure where all address-related fields are at the
  /// root level, such as `json['street']`.
  factory Address.fromJsonWithoutKey(Map<String, dynamic> json) {
    String street = json['street'] ?? "";
    String interiorNumber = json['interiorNumber'] ?? "";
    String exteriorNumber = json['exteriorNumber'] ?? "";
    String postalCode = json['postalCode'] ?? "";
    String locality = json['locality'] ?? "";
    String city = json['city'] ?? "";
    String state = json['state'] ?? "";

    return Address(
      street: street,
      interiorNumber: interiorNumber,
      exteriorNumber: exteriorNumber,
      postalCode: postalCode,
      locality: locality,
      city: city,
      state: state,
    );
  }

  /// Converts the `Address` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'interiorNumber': interiorNumber,
      'exteriorNumber': exteriorNumber,
      'postalCode': postalCode,
      'locality': locality,
      'city': city,
      'state': state,
    };
  }

  /// Provides a map representation of the `Address` object using
  /// attribute names from the [AddressAttributes] enum.
  Map<String, dynamic> get address {
    return {
      AddressAttributes.street.name: street,
      AddressAttributes.interiorNumber.name: interiorNumber,
      AddressAttributes.exteriorNumber.name: exteriorNumber,
      AddressAttributes.postalCode.name: postalCode,
      AddressAttributes.locality.name: locality,
      AddressAttributes.city.name: city,
      AddressAttributes.state.name: state,
    };
  }

  /// Creates an empty [Address] instance with default values.
  factory Address.empty() {
    return Address(
      street: "",
      interiorNumber: "",
      exteriorNumber: "",
      postalCode: "",
      locality: "",
      city: "",
      state: "",
    );
  }

  /// Returns a string representation of the `Address` object for debugging purposes.
  @override
  String toString() {
    return '''
    Address: 
      Street: $street
      Interior Number: $interiorNumber
      Exterior Number: $exteriorNumber
      Postal Code: $postalCode
      Locality: $locality
      City: $city
      State: $state
    ''';
  }
}
