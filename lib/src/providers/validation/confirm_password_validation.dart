import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final confirmPasswordValidatorProvider = StateNotifierProvider.autoDispose<
    ConfirmPasswordValidatorNotifier,
    PasswordValidate>((ref) => ConfirmPasswordValidatorNotifier());

class ConfirmPasswordValidatorNotifier extends StateNotifier<PasswordValidate> {
  ConfirmPasswordValidatorNotifier() : super(passwordConfirmed);

  void vaidate(String password, String confirmedPassword) {
    if (confirmedPassword.isEmpty) {
      state = emptyConfirmPassword;
      return;
    }

    if (password != confirmedPassword) {
      state = passwordNotIdentical;
      return;
    }

    state = passwordConfirmed;
  }

  void reset() {
    state = passwordConfirmed;
  }
}
