import 'enum/enums.dart';

class Address {
  final String street;
  final String interiorNumber;
  final String exteriorNumber;
  final String postalCode;
  final String locality;
  final String city;
  final String state;

  // Constructor
  Address({
    required this.street,
    required this.interiorNumber,
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
      interiorNumber: interiorNumber ?? this.interiorNumber,
      exteriorNumber: exteriorNumber ?? this.exteriorNumber,
      postalCode: postalCode ?? this.postalCode,
      locality: locality ?? this.locality,
      city: city ?? this.city,
      state: state ?? this.state,
    );
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
