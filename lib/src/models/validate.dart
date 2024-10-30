class Validate {
  final bool isValid;
  final int id;
  final String? message;

  Validate({
    required this.isValid,
    required this.id,
    this.message,
  });

  Map<String, dynamic> get validate {
    return {
      "isValid": isValid,
      "id": id,
      "message": message,
    };
  }
}

class EmailValidate extends Validate {
  EmailValidate({
    required super.isValid,
    required super.id,
    super.message,
  });
}

class PasswordValidate extends Validate {
  PasswordValidate({
    required super.isValid,
    required super.id,
    super.message,
  });
}

final EmailValidate validEmail = EmailValidate(
  isValid: true,
  id: 0,
  message: null,
);

final EmailValidate emptyEmail = EmailValidate(
  isValid: false,
  id: 1,
  message: "Email cannot be empty.",
);

final EmailValidate emailFormatError = EmailValidate(
  isValid: false,
  id: 2,
  message: "Invalid email format.",
);

final PasswordValidate validPassword = PasswordValidate(
  isValid: true,
  id: 0,
  message: null,
);

final PasswordValidate emptyPassword = PasswordValidate(
  isValid: false,
  id: 1,
  message: "Password cannot be empty.",
);

final PasswordValidate shortPassword = PasswordValidate(
  isValid: false,
  id: 2,
  message: "Password must be at least 8 characters long.",
);

final PasswordValidate longPassword = PasswordValidate(
  isValid: false,
  id: 3,
  message: "Password must not exceed 20 characters.",
);

final PasswordValidate noSpecialChar = PasswordValidate(
  isValid: false,
  id: 4,
  message: "Password must contain at least one special character.",
);

final PasswordValidate noUppercase = PasswordValidate(
  isValid: false,
  id: 5,
  message: "Password must contain at least one uppercase letter.",
);

final PasswordValidate noLowercase = PasswordValidate(
  isValid: false,
  id: 6,
  message: "Password must contain at least one lowercase letter.",
);

final PasswordValidate noNumeric = PasswordValidate(
  isValid: false,
  id: 7,
  message: "Password must contain at least one numeric character.",
);

final PasswordValidate passwordConfirmed = PasswordValidate(
  isValid: true,
  id: 8,
  message: null,
);

final PasswordValidate emptyConfirmPassword = PasswordValidate(
  isValid: true,
  id: 8,
  message: "Confirm password cannot be empty.",
);

final PasswordValidate passwordNotIdentical = PasswordValidate(
  isValid: false,
  id: 8,
  message: "Passwords do not match.",
);
