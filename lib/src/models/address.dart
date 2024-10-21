import 'enum/address_attributes.dart';

class Address {
  String? _street;
  String? _interiorNumber;
  String? _exteriorNumber;
  String? _postalCode;
  String? _locality;
  String? _city;
  String? _state;

  // Constructor
  Address({
    String? street,
    String? interiorNumber,
    String? exteriorNumber,
    String? postalCode,
    String? locality,
    String? city,
    String? state,
  }) {
    _street = street;
    _interiorNumber = interiorNumber;
    _exteriorNumber = exteriorNumber;
    _postalCode = postalCode;
    _locality = locality;
    _city = city;
    _state = state;
  }

  // Setters
  void setStreet(String street) {
    _street = street;
  }

  void setInteriorNumber(String interiorNumber) {
    _interiorNumber = interiorNumber;
  }

  void setExteriorNumber(String exteriorNumber) {
    _exteriorNumber = exteriorNumber;
  }

  void setPostalCode(String postalCode) {
    _postalCode = postalCode;
  }

  void setLocality(String locality) {
    _locality = locality;
  }

  void setCity(String city) {
    _city = city;
  }

  void setState(String state) {
    _state = state;
  }

  // Getter for the address as a map
  Map<String, dynamic> get address {
    return {
      AddressAttributes.street.name: _street,
      AddressAttributes.interiorNumber.name: _interiorNumber,
      AddressAttributes.exteriorNumber.name: _exteriorNumber,
      AddressAttributes.postalCode.name: _postalCode,
      AddressAttributes.locality.name: _locality,
      AddressAttributes.city.name: _city,
      AddressAttributes.state.name: _state,
    };
  }
}
