enum UserAttributes {
  id(attributeName: 'id'),
  name(attributeName: 'name'),
  paternalSurname(attributeName: 'paternal_surname'),
  maternalSurname(attributeName: 'maternal_surname'),
  birthdate(attributeName: 'birthdate'),
  address(attributeName: 'address'),
  image(attributeName: 'image'),
  email(attributeName: 'email'),
  password(attributeName: 'password'),
  role(attributeName: 'role'),
  status(attributeName: 'status');

  final String attributeName;

  const UserAttributes({
    required this.attributeName,
  });
}
