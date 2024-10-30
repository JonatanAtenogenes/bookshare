import 'package:bookshare/src/models/validate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailValidatorProvider =
    StateNotifierProvider.autoDispose<EmailValidatorNotifier, EmailValidate>(
  (ref) => EmailValidatorNotifier(),
);

class EmailValidatorNotifier extends StateNotifier<EmailValidate> {
  EmailValidatorNotifier() : super(validEmail);

  void validate(String email) {
    if (email.isEmpty) {
      state = emptyEmail;
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      state = emailFormatError;
      return;
    }

    state = validEmail; // Valid input
  }

  void reset() {
    state = validEmail;
  }
}
