import '../enum/enums.dart';

/// Represents a library with various attributes, including its location and collection details.
///
/// This class provides methods to create a `Library` instance from JSON data,
/// convert it to JSON, and copy or retrieve attributes.
class Library {
  /// Unique identifier for the library.
  final String id;

  /// Collection identifier associated with the library.
  final int collectionId;

  /// Name of the library.
  final String name;

  /// Street address of the library.
  final String street;

  /// City where the library is located.
  final String city;

  /// State where the library is located.
  final String state;

  /// Postal code of the library's location.
  final String postalCode;

  /// Constructs a `Library` instance with the specified parameters.
  Library({
    required this.id,
    required this.collectionId,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  /// Creates a copy of the current `Library` instance with updated fields.
  ///
  /// If any parameter is omitted, the original value is retained.
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

  /// Retrieves the attributes of the `Library` as a map.
  ///
  /// Useful for serialization or accessing the library’s properties in a map format.
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

  /// Factory method to create a `Library` instance from JSON data.
  ///
  /// This method expects a `Map<String, dynamic>` that contains the library details.
  /// The library attributes are accessed through a `library` key in the JSON map.
  factory Library.fromJson(Map<String, dynamic> json) {
    final libraryData = json['library'];

    final id = libraryData[LibraryAttributes.id.name] ?? '';
    final collectionId = libraryData[LibraryAttributes.collectionId.name] ?? 0;
    final name = libraryData[LibraryAttributes.name.name] ?? '';
    final street = libraryData[LibraryAttributes.street.name] ?? '';
    final city = libraryData[LibraryAttributes.city.name] ?? '';
    final state = libraryData[LibraryAttributes.state.name] ?? '';
    final postalCode = libraryData[LibraryAttributes.postalCode.name] ?? '';

    return Library(
      id: id,
      collectionId: collectionId,
      name: name,
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
    );
  }

  /// Factory method to create a `Library` instance from JSON data without a key.
  ///
  /// This method assumes the JSON map directly contains the library attributes,
  /// instead of being nested under a `library` key.
  factory Library.fromJsonWithoutKey(Map<String, dynamic> json) {
    final id = json[LibraryAttributes.id.name] ?? '';
    final collectionId = json[LibraryAttributes.collectionId.name] ?? 0;
    final name = json[LibraryAttributes.name.name] ?? '';
    final street = json[LibraryAttributes.street.name] ?? '';
    final city = json[LibraryAttributes.city.name] ?? '';
    final state = json[LibraryAttributes.state.name] ?? '';
    final postalCode = json[LibraryAttributes.postalCode.name] ?? '';

    return Library(
      id: id,
      collectionId: collectionId,
      name: name,
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
    );
  }

  /// Converts the `Library` instance into a JSON map.
  ///
  /// This method returns a map containing the library attributes
  /// that can be used for serialization.
  Map<String, dynamic> toJson() {
    final id = this.id;
    final collectionId = this.collectionId;
    final name = this.name;
    final street = this.street;
    final city = this.city;
    final state = this.state;
    final postalCode = this.postalCode;

    return {
      LibraryAttributes.id.name: id,
      LibraryAttributes.collectionId.name: collectionId,
      LibraryAttributes.name.name: name,
      LibraryAttributes.street.name: street,
      LibraryAttributes.city.name: city,
      LibraryAttributes.state.name: state,
      LibraryAttributes.postalCode.name: postalCode,
    };
  }

  /// Factory method to create an empty `Library` instance with default values.
  ///
  /// Useful for initializing an empty library with placeholder data.
  factory Library.empty() {
    return Library(
      id: '',
      collectionId: 0,
      name: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
    );
  }
}
