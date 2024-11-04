import 'dart:developer';

import 'package:bookshare/src/utils/assets_access.dart';

import '../address/address.dart';
import '../enum/enums.dart';

/// Represents a user with various attributes and methods to manage their data.
class User {
  /// Unique identifier for the user.
  final String id;

  /// Email address of the user.
  final String email;

  /// Password of the user (optional).
  final String? password;

  /// Name of the user (optional).
  final String? name;

  /// Paternal surname of the user (optional).
  final String? paternalSurname;

  /// Maternal surname of the user (optional).
  final String? maternalSurname;

  /// Birthdate of the user (optional).
  final DateTime? birthdate;

  /// Address of the user (optional).
  final Address? address;

  /// URL or path to the user's image (optional).
  final String? image;

  /// Role of the user (e.g., admin, user).
  final String role;

  /// Status indicating if the user is active (optional).
  final bool? status;

  /// Constructor for the `User` class.
  ///
  /// [id] - Unique identifier for the user.
  /// [email] - Email address of the user.
  /// [role] - Role of the user.
  /// [password] - Password of the user (optional).
  /// [name] - Name of the user (optional).
  /// [paternalSurname] - Paternal surname of the user (optional).
  /// [maternalSurname] - Maternal surname of the user (optional).
  /// [birthdate] - Birthdate of the user (optional).
  /// [address] - Address of the user (optional).
  /// [image] - Image URL of the user (optional).
  /// [status] - User's status indicating if active (optional).
  User({
    required this.id,
    required this.email,
    required this.role,
    this.password,
    this.name,
    this.paternalSurname,
    this.maternalSurname,
    this.birthdate,
    this.address,
    this.image,
    this.status,
  });

  /// Creates a copy of the current `User` instance with updated fields.
  ///
  /// Returns a new instance of `User` with updated attributes specified.
  User copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? paternalSurname,
    String? maternalSurname,
    DateTime? birthdate,
    Address? address,
    String? image,
    String? role,
    bool? status,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      paternalSurname: paternalSurname ?? this.paternalSurname,
      maternalSurname: maternalSurname ?? this.maternalSurname,
      birthdate: birthdate ?? this.birthdate,
      address: address ?? this.address,
      image: image ?? this.image,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  /// Factory constructor for creating a `User` from JSON.
  ///
  /// [json] - JSON map representing a user.
  /// Returns a `User` instance populated with data from the JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    log("user json: $json");
    String id = json['user']['id'] ?? "";
    String email = json['user']['email'] ?? "";
    String password = json['user']['password'] ?? "";
    String name = json['user']['name'] ?? "";
    String paternalSurname = json['user']['paternal_surname'] ?? "";
    String maternalSurname = json['user']['maternal_surname'] ?? "";
    String image = json['user']['image'] ?? ""; // Corrected to use 'image'
    String role = json['user']['role'] ?? Roles.user.name;
    bool status = json['user']['status'] ?? true;

    // Safely parse the birthdate
    DateTime birthdate;
    if (json['user']['birthdate'] is String) {
      birthdate =
          DateTime.tryParse(json['user']['birthdate']) ?? DateTime.now();
    } else if (json['user']['birthdate'] is DateTime) {
      birthdate = json['user']['birthdate'];
    } else {
      birthdate = DateTime.now();
    }

    // Safely parse the address, defaulting to an empty Address if null
    Address address = json['user']['address'] != null
        ? Address.fromJson(json['user']['address'])
        : Address.empty();

    return User(
      id: id,
      email: email,
      password: password,
      name: name,
      paternalSurname: paternalSurname,
      maternalSurname: maternalSurname,
      birthdate: birthdate,
      address: address,
      image: image,
      role: role,
      status: status,
    );
  }

  /// Converts the `User` object to JSON.
  ///
  /// Returns a JSON map representation of the user.
  Map<String, dynamic> toJson() {
    return {
      UserAttributes.id.attributeName: id,
      UserAttributes.name.attributeName: name,
      UserAttributes.paternalSurname.attributeName: paternalSurname,
      UserAttributes.maternalSurname.attributeName: maternalSurname,
      UserAttributes.birthdate.attributeName: birthdate?.toIso8601String(),
      UserAttributes.email.attributeName: email,
      UserAttributes.password.attributeName: password,
      UserAttributes.address.attributeName: address?.toJson(),
      UserAttributes.image.attributeName: image,
      UserAttributes.role.attributeName: role,
      UserAttributes.status.attributeName: status,
    };
  }

  /// Factory constructor for an empty `User` instance with default values.
  ///
  /// Returns a `User` instance where all attributes are set to default values.
  factory User.empty() {
    return User(
      id: "",
      email: "",
      role: Roles.user.name,
      password: "",
      name: "",
      paternalSurname: "",
      maternalSurname: "",
      birthdate: DateTime(1970, 1, 1),
      // Arbitrary date as a default
      address: Address.empty(),
      // Empty address instance
      image: AssetsAccess.defaultUserImage,
      status: true, // Assuming default status as active
    );
  }

  /// Getter for the user attributes as a map.
  ///
  /// Returns a map representation of the user attributes,
  /// which can be useful for serialization.
  Map<String, dynamic> get user {
    return {
      UserAttributes.id.name: id,
      UserAttributes.name.name: name,
      UserAttributes.paternalSurname.name: paternalSurname,
      UserAttributes.maternalSurname.name: maternalSurname,
      UserAttributes.birthdate.name: birthdate,
      UserAttributes.address.name: address?.address,
      UserAttributes.email.name: email,
      UserAttributes.password.name: password,
      UserAttributes.image.name: image,
      UserAttributes.role.name: role,
      UserAttributes.status.name: status,
    };
  }

  /// Converts the `User` instance to a string representation for debugging.
  @override
  String toString() {
    return '''
      User(
        id: $id,
        email: $email,
        password: ${password ?? "N/A"},
        name: ${name ?? "N/A"},
        paternalSurname: ${paternalSurname ?? "N/A"},
        maternalSurname: ${maternalSurname ?? "N/A"},
        birthdate: ${birthdate?.toIso8601String() ?? "N/A"},
        address: ${address != null ? address.toString() : "N/A"},
        image: ${image ?? "N/A"},
        role: $role,
        status: ${status ?? "N/A"}
      )
    ''';
  }
}