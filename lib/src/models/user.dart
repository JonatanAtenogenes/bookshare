import 'address.dart';
import 'enum/enums.dart';

class User {
  final String id;
  final String name;
  final String paternalSurname;
  final String maternalSurname;
  final DateTime birthdate;
  final String email;
  final String password;
  final Address address;
  final String image;
  final String role;
  final bool status;

  // Constructor
  User({
    required this.id,
    required this.name,
    required this.paternalSurname,
    required this.maternalSurname,
    required this.image,
    required this.birthdate,
    required this.address,
    required this.email,
    required this.password,
    required this.role,
    required this.status,
  });

  // CopyWith
  User copyWith({
    String? id,
    String? name,
    String? paternalSurname,
    String? maternalSurname,
    DateTime? birthdate,
    String? email,
    String? password,
    Address? address,
    String? image,
    String? role,
    bool? status,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      paternalSurname: paternalSurname ?? this.paternalSurname,
      maternalSurname: maternalSurname ?? this.maternalSurname,
      image: image ?? this.image,
      birthdate: birthdate ?? this.birthdate,
      address: address ?? this.address,
      email: email ?? this.password,
      password: password ?? this.password,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  /// Factory constructor for creating a `User` from JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      paternalSurname: json['paternalSurname'] as String,
      maternalSurname: json['maternalSurname'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      email: json['email'] as String,
      password: json['password'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      image: json['image'] as String,
      role: json['role'] as String? ?? Roles.user.name,
      status: json['status'] as bool,
    );
  }

  /// Converts the `User` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'paternalSurname': paternalSurname,
      'maternalSurname': maternalSurname,
      'birthdate': birthdate.toIso8601String(),
      'email': email,
      'password': password,
      'address': address.toJson(),
      'image': image,
      'role': role,
      'status': status,
    };
  }

  // Getter for the user as a map
  Map<String, dynamic> get user {
    return {
      UserAttributes.id.name: id,
      UserAttributes.name.name: name,
      UserAttributes.paternalSurname.name: paternalSurname,
      UserAttributes.maternalSurname.name: maternalSurname,
      UserAttributes.birthdate.name: birthdate,
      UserAttributes.address.name: address.address,
      UserAttributes.email.name: email,
      UserAttributes.password.name: password,
      UserAttributes.image.name: image,
      UserAttributes.role.name: role,
      UserAttributes.status.name: status,
    };
  }
}
