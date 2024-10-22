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
  final String role = Roles.user.name;
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
      status: status ?? this.status,
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
      UserAttributes.address.name: address.address,
      UserAttributes.email.name: email,
      UserAttributes.password.name: password,
      UserAttributes.image.name: image,
      UserAttributes.role.name: role,
      UserAttributes.status.name: status,
    };
  }
}
