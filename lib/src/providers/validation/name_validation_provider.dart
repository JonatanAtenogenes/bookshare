import 'package:bookshare/src/models/validation/name_validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier for validating user name input.
///
/// This [StateNotifier] validates the provided name based on specific criteria:
/// - Non-empty input
/// - Minimum length of 3 characters
/// - Maximum length of 50 characters
/// - Alphabetic characters only
///
/// The notifier returns specific instances of [NameValidation] based on the validation results.
class NameValidationNotifier extends StateNotifier<NameValidation> {
  NameValidationNotifier() : super(validName);

  /// Validates the given [name] and returns a corresponding [NameValidation] state.
  ///
  /// Validation checks:
  /// - Returns [emptyName] if the name is empty.
  /// - Returns [shortName] if the name is shorter than 3 characters.
  /// - Returns [longName] if the name is longer than 50 characters.
  /// - Returns [invalidCharactersInName] if the name contains non-alphabetic characters.
  /// - Returns [validName] if all checks pass.
  NameValidation validate(String name) {
    if (name.isEmpty) {
      state = emptyName;
      return emptyName;
    }

    if (name.length < 3) {
      state = shortName;
      return shortName;
    }

    if (name.length > 50) {
      state = longName;
      return longName;
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      state = invalidCharactersInName;
      return invalidCharactersInName;
    }

    state = validName;
    return validName;
  }
}

/// Provider for validating the first name input.
final nameValidationNotifierProvider =
    StateNotifierProvider.autoDispose<NameValidationNotifier, NameValidation>(
  (ref) => NameValidationNotifier(),
);

/// Provider for validating the paternal last name input.
final paternalValidationNotifierProvider =
    StateNotifierProvider.autoDispose<NameValidationNotifier, NameValidation>(
  (ref) => NameValidationNotifier(),
);

/// Provider for validating the maternal last name input.
final maternalValidationNotifierProvider =
    StateNotifierProvider.autoDispose<NameValidationNotifier, NameValidation>(
  (ref) => NameValidationNotifier(),
);
