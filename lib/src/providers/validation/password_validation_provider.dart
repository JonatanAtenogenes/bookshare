import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordValidatorProvider = StateNotifierProvider.autoDispose<
    PasswordValidatorNotifier,
    PasswordValidate>((ref) => PasswordValidatorNotifier());

class PasswordValidatorNotifier extends StateNotifier<PasswordValidate> {
  PasswordValidatorNotifier() : super(validPassword);

  final specialCharacters = "[!@#\$%^&*(),.?\":{}|<>]";

  Validate validate(String password) {
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

  void reset() {
    state = validPassword;
  }
}
