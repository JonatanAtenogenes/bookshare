import 'enum/enums.dart';

class Library {
  final String id;
  final int collectionId;
  final String name;
  final String street;
  final String city;
  final String state;
  final String postalCode;

  // Constructor
  Library({
    required this.id,
    required this.collectionId,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  // CopyWith
  Library copyWith({
    String? id,
    int? collectionId,
    String? name,
    String? street,
    String? city,
    String? state,
    String? postalCode,
  }) {
    return Library(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      name: name ?? this.name,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  // Getter for the library as a map
  Map<String, dynamic> get library {
    return {
      LibraryAttributes.id.name: id,
      LibraryAttributes.collectionId.name: collectionId,
      LibraryAttributes.name.name: name,
      LibraryAttributes.postalCode.name: postalCode,
      LibraryAttributes.street.name: street,
      LibraryAttributes.city.name: city,
      LibraryAttributes.state.name: state,
    };
  }
}
