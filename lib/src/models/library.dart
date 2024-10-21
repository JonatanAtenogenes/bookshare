import 'enum/library_attributes.dart';

class Library {
  String? _id;
  int? _collectionId;
  String? _name;
  String? _street;
  String? _city;
  String? _state;
  String? _postalCode;

  // Constructor
  Library({
    String? id,
    int? collectionId,
    String? name,
    String? street,
    String? city,
    String? state,
    String? postalCode,
  })  : _id = id,
        _collectionId = collectionId,
        _name = name,
        _postalCode = postalCode,
        _street = street,
        _city = city,
        _state = state;

  // Setters
  void setId(String id) {
    _id = id;
  }

  void setCollectionId(int collectionId) {
    _collectionId = collectionId;
  }

  void setName(String name) {
    _name = name;
  }

  void setStreet(String street) {
    _street = street;
  }

  void setCity(String city) {
    _city = city;
  }

  void setState(String state) {
    _state = state;
  }

  void setPostalCode(String postalCode) {
    _postalCode = postalCode;
  }

  // Getter for the library as a map
  Map<String, dynamic> get library {
    return {
      LibraryAttributes.id.name: _id,
      LibraryAttributes.collectionId.name: _collectionId,
      LibraryAttributes.name.name: _name,
      LibraryAttributes.postalCode.name: _postalCode,
      LibraryAttributes.street.name: _street,
      LibraryAttributes.city.name: _city,
      LibraryAttributes.state.name: _state,
    };
  }
}
