import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordValidatorProvider = StateNotifierProvider.autoDispose<
    PasswordValidatorNotifier,
    PasswordValidate>((ref) => PasswordValidatorNotifier());

class PasswordValidatorNotifier extends StateNotifier<PasswordValidate> {
  PasswordValidatorNotifier() : super(validPassword);

  final specialCharacters = "[!@#\$%^&*(),.?\":{}|<>]";

  void validate(String password) {
    if (password.isEmpty) {
      state = emptyPassword;
      return;
    }

    if (password.length < 8) {
      state = shortPassword;
      return;
    }

    if (password.length > 20) {
      state = longPassword;
      return;
    }

    if (!RegExp((specialCharacters)).hasMatch(password)) {
      state = noSpecialChar;
      return;
    }

    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      state = noUppercase;
      return;
    }

    if (!RegExp(r"[a-z]").hasMatch(password)) {
      state = noLowercase;
      return;
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      state = noNumeric;
      return;
    }

    state = validPassword;
  }

  void reset() {
    state = validPassword;
  }
}
