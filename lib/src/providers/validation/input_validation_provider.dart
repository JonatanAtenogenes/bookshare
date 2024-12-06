import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/models/validation/name_validation.dart';
import 'package:bookshare/src/models/validation/number_validation.dart';
import 'package:bookshare/src/models/validation/text_validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier for managing input validations, extending [StateNotifier].
///
/// This class handles the validation logic for various input fields,
/// allowing for real-time feedback on user input for both numbers
/// and text fields. It maintains the current state of the validation
/// and updates it based on user input.
class InputValidationNotifier extends StateNotifier<Validation> {
  /// Creates an instance of [InputValidationNotifier], initializing
  /// the state to a valid name status.
  InputValidationNotifier() : super(validName);

  /// Validates a numeric input based on a specified minimum length.
  ///
  /// This method checks if the provided [number] string is valid based
  /// on the following criteria:
  /// - It cannot be empty.
  /// - It must contain only numeric characters.
  /// - It must meet the specified minimum length.
  ///
  /// Returns a [NumberValidation] object indicating the validity
  /// of the input. The state of the notifier is updated accordingly.
  NumberValidation validateNumber(String number, int min) {
    // Check if the number input is empty
    if (number.isEmpty) {
      state = emptyNumber; // Invalid state for empty input
      return emptyNumber;
    }

    // Check if the input contains only numeric characters
    if (!RegExp(r'^\d+$').hasMatch(number)) {
      state = nonNumeric; // Invalid state for non-numeric characters
      return nonNumeric;
    }

    // Check if the input meets the minimum length requirement
    if (number.length < min) {
      state = shortNumber; // Invalid state for minimum length
      return shortNumber;
    }

    // If valid, update state to valid number
    state = validNumber;
    return validNumber;
  }

  /// Validates a text input based on defined length constraints.
  ///
  /// This method evaluates the provided [text] string based on
  /// the following rules:
  /// - It cannot be empty.
  /// - It must have a minimum length of 3 characters.
  /// - It must not exceed a maximum length of 50 characters.
  ///
  /// Returns a [TextValidation] object indicating the validity
  /// of the input. The state of the notifier is updated accordingly.
  TextValidation validateText(String text) {
    // Check if the text input is empty
    if (text.isEmpty) {
      state = emptyText; // Invalid state for empty input
      return emptyText;
    }

    // Check if the text meets the minimum length requirement
    if (text.length < 3) {
      state = shortText; // Invalid state for short input
      return shortText;
    }

    // Check if the text exceeds the maximum length
    if (text.length > 50) {
      state = longText; // Invalid state for long input
      return longText;
    }

    // If valid, update state to valid text
    state = validText; // Ensure you have a valid state for text
    return validText;
  }
}

/// Provider for validating street input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// specifically for validating the street field, allowing
/// for real-time validation updates and state management.
final streetValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating interior number input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// specifically for validating the interior number field, ensuring
/// that users receive appropriate feedback on their input.
final interiorNumberValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating exterior number input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// for validating the exterior number field, facilitating
/// validation logic and state management for this input.
final exteriorNumberValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating postal code input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// for validating the postal code field, providing feedback on
/// user input in real-time.
final postalCodeValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating locality input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// for validating the locality field, ensuring that the input
/// adheres to defined validation rules.
final localityValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating city input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// for validating the city field, enabling real-time validation
/// and feedback for users.
final cityValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);

/// Provider for validating state input.
///
/// This provider creates an instance of [InputValidationNotifier]
/// for validating the state field, facilitating state management
/// and validation logic for user input.
final stateValidationNotifierProvider =
    StateNotifierProvider.autoDispose<InputValidationNotifier, Validation>(
  (ref) => InputValidationNotifier(),
);
