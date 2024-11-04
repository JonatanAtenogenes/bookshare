import '../models.dart';

/// The `BirthdateValidation` class extends the `Validation` class to provide
/// specific validation states for birthdate requirements.
///
/// It utilizes predefined instances to represent different types of birthdate
/// validation states.
class BirthdateValidation extends Validation {
  /// Creates an instance of `BirthdateValidation` with the given validation status,
  /// identifier, and optional message.
  ///
  /// - `isValid`: Indicates whether the birthdate meets the validation criteria.
  /// - `id`: A unique identifier for the validation result.
  /// - `message`: An optional message describing the validation outcome.
  BirthdateValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

// Predefined birthdate validation states

/// Represents a valid birthdate with no errors.
final BirthdateValidation validBirthdate = BirthdateValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents a validation state where the birthdate is empty.
final BirthdateValidation emptyBirthdate = BirthdateValidation(
  isValid: false,
  id: 1,
  message: "Birthdate cannot be empty.",
);

/// Represents a validation state where the birthdate is not in the correct format.
final BirthdateValidation invalidFormat = BirthdateValidation(
  isValid: false,
  id: 2,
  message: "Birthdate must be in the format YYYY-MM-DD.",
);

/// Represents a validation state where the birthdate indicates a future date.
final BirthdateValidation futureDate = BirthdateValidation(
  isValid: false,
  id: 3,
  message: "Birthdate cannot be in the future.",
);

/// Represents a validation state where the user is underage (less than 8 years old).
final BirthdateValidation underage = BirthdateValidation(
  isValid: false,
  id: 4,
  message: "You must be at least 8 years old.",
);
