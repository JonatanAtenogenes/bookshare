import 'package:bookshare/src/models/address.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/models/user/user.dart';
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
      street: AddressAttributes.street.name,
      interiorNumber: AddressAttributes.interiorNumber.name,
      exteriorNumber: AddressAttributes.exteriorNumber.name,
      postalCode: AddressAttributes.postalCode.name,
      locality: AddressAttributes.locality.name,
      city: AddressAttributes.city.name,
      state: AddressAttributes.state.name,
    ),
    email: "alice.smith@example.com",
    password: "password123",
    status: true,
    role: Roles.user.name,
  ),
);

final emptyUserProvider = Provider<User>(
  (ref) => User(
    id: UserAttributes.id.attributeName,
    name: UserAttributes.name.attributeName,
    paternalSurname: UserAttributes.paternalSurname.attributeName,
    maternalSurname: UserAttributes.maternalSurname.attributeName,
    image: AssetsAccess.defaultUserImage,
    birthdate: DateTime.now(),
    address: Address(
      street: AddressAttributes.street.name,
      interiorNumber: AddressAttributes.interiorNumber.name,
      exteriorNumber: AddressAttributes.exteriorNumber.name,
      postalCode: AddressAttributes.postalCode.name,
      locality: AddressAttributes.locality.name,
      city: AddressAttributes.city.name,
      state: AddressAttributes.state.name,
    ),
    email: UserAttributes.email.attributeName,
    password: UserAttributes.password.attributeName,
    status: true,
    role: Roles.user.name,
  ),
);
