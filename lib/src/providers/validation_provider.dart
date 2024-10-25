import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailValidatorProvider = StateNotifierProvider.autoDispose<
    EmailValidatorNotifier, Map<String, dynamic>?>(
  (ref) => EmailValidatorNotifier(),
);

class EmailValidatorNotifier extends StateNotifier<Map<String, dynamic>?> {
  EmailValidatorNotifier() : super({'valid': true, 'error': null});

  void validate(String value) {
    if (value.isEmpty) {
      state = {'valid': false, 'error': "Email cannot be empty."};
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      state = {'valid': false, 'error': "Invalid email format."};
    } else {
      state = {'valid': false, 'error': null}; // Valid input
    }
  }

  void reset() {
    state = {'valid': true, 'error': null};
  }
}

class PasswordValidatorNotifier extends StateNotifier<Map<String, dynamic>> {
  PasswordValidatorNotifier() : super({'valid': true, 'error': null});

  void validate(String value) {}
}
