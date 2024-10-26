import 'package:bookshare/src/models/address.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/models/user.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleUserProvider = Provider<User>(
  (ref) => User(
    id: "1",
    name: "Alice",
    paternalSurname: "Smith",
    maternalSurname: "Johnson",
    image: AssetsAccess.defaultUserImage,
    birthdate: DateTime(1990, 5, 15),
    address: Address(
      street: "Maple Street",
      interiorNumber: "12A",
      exteriorNumber: "45",
      postalCode: "12345",
      locality: "Downtown",
      city: "New York",
      state: "NY",
    ),
    email: "alice.smith@example.com",
    password: "password123",
    status: true,
    role: Roles.user.name,
  ),
);
