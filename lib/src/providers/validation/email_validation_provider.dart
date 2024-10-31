import 'package:bookshare/src/models/validate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailValidatorProvider =
    StateNotifierProvider.autoDispose<EmailValidatorNotifier, EmailValidate>(
  (ref) => EmailValidatorNotifier(),
);

class EmailValidatorNotifier extends StateNotifier<EmailValidate> {
  EmailValidatorNotifier() : super(validEmail);

  EmailValidate validate(String email) {
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

  void reset() {
    state = validEmail;
  }
}
