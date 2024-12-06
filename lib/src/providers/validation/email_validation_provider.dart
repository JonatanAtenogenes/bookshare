import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/validation/email_validation.dart';

/// A provider for email validation that creates an instance of
/// [EmailValidationNotifier], which manages the email validation state.
///
/// This provider is auto-disposed when no longer in use.
final emailValidationProvider =
    StateNotifierProvider.autoDispose<EmailValidationNotifier, EmailValidation>(
  (ref) => EmailValidationNotifier(),
);

/// A notifier class that manages the state of email validation using
/// the `StateNotifier` from the Riverpod library.
///
/// It allows validation of an email address based on specific criteria
/// and provides methods to reset and update the validation state.
class EmailValidationNotifier extends StateNotifier<EmailValidation> {
  /// Initializes the email validation notifier with a valid initial state.
  EmailValidationNotifier() : super(validEmail);

  /// Validates the provided email string.
  ///
  /// - Returns an [EmailValidation] state based on the input:
  ///   - If the email is empty, sets and returns `emptyEmail`.
  ///   - If the email format is invalid, sets and returns `emailFormatError`.
  ///   - Otherwise, sets and returns `validEmail`.
  Validation validate(String email) {
    if (email.isEmpty) {
      state = emptyEmail;
      return emptyEmail;
    }

    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      state = emailFormatError;
      return emailFormatError;
    }

    state = validEmail; // Valid input.
    return validEmail;
  }

  /// Resets the email validation state to `validEmail`, indicating a
  /// default valid state.
  void reset() {
    state = validEmail;
  }
}
