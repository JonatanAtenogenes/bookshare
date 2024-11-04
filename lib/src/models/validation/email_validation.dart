import '../models.dart';

/// The `EmailValidation` class extends the `Validation` class to provide
/// specific validation states for email requirements.
///
/// It utilizes predefined instances to represent different types of email
/// validation states.
class EmailValidation extends Validation {
  /// Creates an instance of `EmailValidation` with the given validation status,
  /// identifier, and optional message.
  ///
  /// - `isValid`: Indicates whether the email meets the validation criteria.
  /// - `id`: A unique identifier for the validation result.
  /// - `message`: An optional message describing the validation outcome.
  EmailValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

// Predefined email validation states

/// Represents a valid email with no errors.
final EmailValidation validEmail = EmailValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents a validation state where the email field is empty.
final EmailValidation emptyEmail = EmailValidation(
  isValid: false,
  id: 1,
  message: "Email cannot be empty.",
);

/// Represents a validation state where the email format is invalid.
final EmailValidation emailFormatError = EmailValidation(
  isValid: false,
  id: 2,
  message: "Invalid email format.",
);
