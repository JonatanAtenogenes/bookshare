import '../models.dart';

/// The `NameValidation` class extends the `Validation` class to provide
/// specific validation states for name requirements.
///
/// It utilizes predefined instances to represent different types of name
/// validation states.
class NameValidation extends Validation {
  /// Creates an instance of `NameValidation` with the given validation status,
  /// identifier, and optional message.
  ///
  /// - `isValid`: Indicates whether the name meets the validation criteria.
  /// - `id`: A unique identifier for the validation result.
  /// - `message`: An optional message describing the validation outcome.
  NameValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

// Predefined name validation states

/// Represents a valid name with no errors.
final NameValidation validName = NameValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents a validation state where the name is empty.
final NameValidation emptyName = NameValidation(
  isValid: false,
  id: 1,
  message: "Name cannot be empty.",
);

/// Represents a validation state where the name is too short.
final NameValidation shortName = NameValidation(
  isValid: false,
  id: 2,
  message: "Name must be at least 3 characters long.",
);

/// Represents a validation state where the name is too long.
final NameValidation longName = NameValidation(
  isValid: false,
  id: 3,
  message: "Name must not exceed 50 characters.",
);

/// Represents a validation state where the name contains non-alphabetic characters.
final NameValidation invalidCharactersInName = NameValidation(
  isValid: false,
  id: 4,
  message: "Name must contain only alphabetic characters.",
);

/// Represents a validation state where the name contains forbidden words.
final NameValidation forbiddenWordInName = NameValidation(
  isValid: false,
  id: 5,
  message: "Name contains inappropriate words.",
);
