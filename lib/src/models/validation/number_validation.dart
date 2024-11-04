import 'package:bookshare/src/models/models.dart';

/// A class that represents the validation state for numeric input.
///
/// This class extends [Validation] and provides instances for various
/// numeric validation scenarios, including checks for non-emptiness,
/// numeric-only content, and a minimum length requirement.
class NumberValidation extends Validation {
  NumberValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

/// Instances of [NumberValidation] for various validation scenarios.

/// Represents a valid number state.
final NumberValidation validNumber = NumberValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents an invalid state when the input is empty.
final NumberValidation emptyNumber = NumberValidation(
  isValid: false,
  id: 1,
  message: "Input cannot be empty.",
);

/// Represents an invalid state when the input contains non-numeric characters.
final NumberValidation nonNumeric = NumberValidation(
  isValid: false,
  id: 2,
  message: "Input must contain only numbers.",
);

/// Represents an invalid state when the input does not meet the minimum length.
final NumberValidation shortNumber = NumberValidation(
  isValid: false,
  id: 3,
  message: "Input does not meet the minimum length.",
);
