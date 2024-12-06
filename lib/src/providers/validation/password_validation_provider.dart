import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/validation/password_validation.dart';

/// A provider for password validation that creates an instance of
/// [PasswordValidatorNotifier], which manages the password validation state.
///
/// This provider is auto-disposed when no longer in use.
final passwordValidatorProvider = StateNotifierProvider.autoDispose<
    PasswordValidatorNotifier,
    PasswordValidation>((ref) => PasswordValidatorNotifier());

/// A notifier class that manages the state of password validation using
/// the `StateNotifier` from the Riverpod library.
///
/// This class provides methods to validate a password based on length,
/// character requirements, and other constraints. It also allows
/// resetting the state to a valid password state.
class PasswordValidatorNotifier extends StateNotifier<PasswordValidation> {
  /// Initializes the password validator notifier with a valid initial state.
  PasswordValidatorNotifier() : super(validPassword);

  /// A string containing the special characters required in a valid password.
  final specialCharacters = "[!@#\$%^&*(),.?\":{}|<>]";

  /// Validates the provided password based on various criteria.
  ///
  /// - Returns a [PasswordValidation] state based on the input:
  ///   - If the password is empty, sets and returns `emptyPassword`.
  ///   - If the password is shorter than 8 characters, sets and returns `shortPassword`.
  ///   - If the password is longer than 20 characters, sets and returns `longPassword`.
  ///   - If the password lacks a special character, sets and returns `noSpecialChar`.
  ///   - If the password lacks an uppercase letter, sets and returns `noUppercase`.
  ///   - If the password lacks a lowercase letter, sets and returns `noLowercase`.
  ///   - If the password lacks a numeric character, sets and returns `noNumeric`.
  ///   - Otherwise, sets and returns `validPassword` for a valid input.
  Validation validate(String password) {
    if (password.isEmpty) {
      state = emptyPassword;
      return emptyPassword;
    }

    if (password.length < 8) {
      state = shortPassword;
      return shortPassword;
    }

    if (password.length > 20) {
      state = longPassword;
      return longPassword;
    }

    if (!RegExp((specialCharacters)).hasMatch(password)) {
      state = noSpecialChar;
      return noSpecialChar;
    }

    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      state = noUppercase;
      return noUppercase;
    }

    if (!RegExp(r"[a-z]").hasMatch(password)) {
      state = noLowercase;
      return noLowercase;
    }

    if (!RegExp(r"[0-9]").hasMatch(password)) {
      state = noNumeric;
      return noNumeric;
    }

    state = validPassword;
    return validPassword;
  }

  /// Resets the password validation state to `validPassword`, representing a
  /// default valid state.
  void reset() {
    state = validPassword;
  }
}
