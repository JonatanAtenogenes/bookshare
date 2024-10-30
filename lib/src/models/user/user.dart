import '../address.dart';
import '../enum/enums.dart';

class User {
  final String id;
  final String email;
  final String? password;
  final String? name;
  final String? paternalSurname;
  final String? maternalSurname;
  final DateTime? birthdate;
  final Address? address;
  final String? image;
  final String role;
  final bool? status;

  // Constructor
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

  // CopyWith
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
  factory User.fromJson(Map<String, dynamic> json) {
    String id = json['user']['id'] ?? "";
    String email = json['user']['email'] ?? "";
    String password = json['user']['password'] ?? "";
    String name = json['user']['name'] ?? "";
    String paternalSurname = json['user']['paternal_surname'] ?? "";
    String maternalSurname = json['user']['maternal_surname'] ?? "";
    String image = json['user']['id'] ?? "";
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

  // Factory constructor for an empty User
  factory User.empty() {
    return User(
      id: "",
      email: "",
      role: Roles.user.name,
      // Default role as user
      password: "",
      name: "",
      paternalSurname: "",
      maternalSurname: "",
      birthdate: DateTime(1970, 1, 1),
      // Arbitrary date as a default
      address: Address.empty(),
      // Empty address instance
      image: "",
      status: true, // Assuming default status as active
    );
  }

  // Getter for the user as a map
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

  // toString method for better debugging
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
