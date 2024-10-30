import 'enum/enums.dart';

class Address {
  final String street;
  final String? interiorNumber;
  final String exteriorNumber;
  final String postalCode;
  final String locality;
  final String city;
  final String state;

  // Constructor
  Address({
    required this.street,
    this.interiorNumber,
    required this.exteriorNumber,
    required this.postalCode,
    required this.locality,
    required this.city,
    required this.state,
  });

  // CopyWith
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

  // Factory constructor for creating an `Address` from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    String street = json['street'] ?? "";
    String interiorNumber = json['interior_number'] ?? "";
    String exteriorNumber = json['exterior_number'] ?? "";
    String postalCode = json['postal_code'] ?? "";
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

  // Getter for the address as a map
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

  // Factory constructor for an empty Address
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

  // To String
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
