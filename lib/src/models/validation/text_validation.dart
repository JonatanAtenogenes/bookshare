import 'package:bookshare/src/models/models.dart';

/// A class that represents the validation state for text input.
///
/// This class extends [Validation] and provides instances for various
/// text validation scenarios, including checks for non-emptiness.
class TextValidation extends Validation {
  TextValidation({
    required super.isValid,
    required super.id,
    super.message,
  });
}

/// Instances of [TextValidation] for various validation scenarios.

/// Represents a valid text state.
final TextValidation validText = TextValidation(
  isValid: true,
  id: 0,
  message: null,
);

/// Represents an invalid state when the input is empty.
final TextValidation emptyText = TextValidation(
  isValid: false,
  id: 1,
  message: "Input cannot be empty.",
);

/// Represents an invalid state when the input is too short.
final TextValidation shortText = TextValidation(
  isValid: false,
  id: 2,
  message: "Input must be at least 3 characters long.",
);

/// Represents an invalid state when the input is too long.
final TextValidation longText = TextValidation(
  isValid: false,
  id: 3,
  message: "Input must not exceed 50 characters.",
);
