import 'address.dart';
import 'enum/roles.dart';
import 'enum/user_attributes.dart';

class User {
  String? _id;
  String? _name;
  String? _paternalSurname;
  String? _maternalSurname;
  DateTime? _birthdate;
  String? _email;
  String? _password;
  Address? _address;
  String? _image;
  final String _role = Roles.user.name;
  bool _status = true;

  // Constructor
  User({
    String? id,
    String? name,
    String? paternalSurname,
    String? maternalSurname,
    String? image,
    DateTime? birthdate,
    Address? address,
    String? email,
    String? password,
  })  : _id = id,
        _name = name,
        _paternalSurname = paternalSurname,
        _maternalSurname = maternalSurname,
        _image = image,
        _birthdate = birthdate,
        _address = address,
        _email = email,
        _password = password;

  // Setters
  void setId(String id) {
    _id = id;
  }

  void setName(String name) {
    _name = name;
  }

  void setPaternalSurname(String paternalSurname) {
    _paternalSurname = paternalSurname;
  }

  void setMaternalSurname(String maternalSurname) {
    _maternalSurname = maternalSurname;
  }

  void setBirthdate(DateTime birthdate) {
    _birthdate = birthdate;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setAddress(Address address) {
    _address = address;
  }

  void setImage(String image) {
    _image = image;
  }

  void setStatus(bool status) {
    _status = status;
  }

  // Getter for the user as a map
  Map<String, dynamic> get user {
    return {
      UserAttributes.id.name: _id,
      UserAttributes.name.name: _name,
      UserAttributes.paternalSurname.name: _paternalSurname,
      UserAttributes.maternalSurname.name: _maternalSurname,
      UserAttributes.birthdate.name: _birthdate,
      UserAttributes.address.name: _address?.address,
      UserAttributes.email.name: _email,
      UserAttributes.password.name: _password,
      UserAttributes.image.name: _image,
      UserAttributes.role.name: _role,
      UserAttributes.status.name: _status,
    };
  }
}
