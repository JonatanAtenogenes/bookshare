import '../models.dart';

/// The `PasswordValidation` class extends the `Validation` class to provide
/// specific validation states for password requirements.
///
/// It utilizes predefined instances to represent different types of password
/// validation states.
class PasswordValidation extends Validation {
  /// Creates an instance of `PasswordValidation` with the given validation status,
  /// identifier, and optional message.
  ///
  /// - `isValid`: Indicates whether the password meets the validation criteria.
  /// - `id`: A unique identifier for the validation result.
  /// - `message`: An optional message describing the validation outcome.
  PasswordValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

// Predefined password validation states

/// Represents a valid password with no errors.
final PasswordValidation validPassword = PasswordValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents a validation state where the password is empty.
final PasswordValidation emptyPassword = PasswordValidation(
  isValid: false,
  id: 1,
  message: "Password cannot be empty.",
);

/// Represents a validation state where the password is too short.
final PasswordValidation shortPassword = PasswordValidation(
  isValid: false,
  id: 2,
  message: "Password must be at least 8 characters long.",
);

/// Represents a validation state where the password is too long.
final PasswordValidation longPassword = PasswordValidation(
  isValid: false,
  id: 3,
  message: "Password must not exceed 20 characters.",
);

/// Represents a validation state where the password lacks a special character.
final PasswordValidation noSpecialChar = PasswordValidation(
  isValid: false,
  id: 4,
  message: "Password must contain at least one special character.",
);

/// Represents a validation state where the password lacks an uppercase letter.
final PasswordValidation noUppercase = PasswordValidation(
  isValid: false,
  id: 5,
  message: "Password must contain at least one uppercase letter.",
);

/// Represents a validation state where the password lacks a lowercase letter.
final PasswordValidation noLowercase = PasswordValidation(
  isValid: false,
  id: 6,
  message: "Password must contain at least one lowercase letter.",
);

/// Represents a validation state where the password lacks a numeric character.
final PasswordValidation noNumeric = PasswordValidation(
  isValid: false,
  id: 7,
  message: "Password must contain at least one numeric character.",
);

/// Represents a state where the password and confirm password fields match.
final PasswordValidation passwordConfirmed = PasswordValidation(
  isValid: true,
  id: 8,
  message: null,
);

/// Represents a validation state where the confirm password field is empty.
final PasswordValidation emptyConfirmPassword = PasswordValidation(
  isValid: false,
  id: 9,
  message: "Confirm password cannot be empty.",
);

/// Represents a validation state where the passwords do not match.
final PasswordValidation passwordNotIdentical = PasswordValidation(
  isValid: false,
  id: 10,
  message: "Passwords do not match.",
);
