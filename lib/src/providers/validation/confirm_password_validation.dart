import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final confirmPasswordValidatorProvider = StateNotifierProvider.autoDispose<
    ConfirmPasswordValidatorNotifier,
    PasswordValidate>((ref) => ConfirmPasswordValidatorNotifier());

class ConfirmPasswordValidatorNotifier extends StateNotifier<PasswordValidate> {
  ConfirmPasswordValidatorNotifier() : super(passwordConfirmed);

  Validate vaidate(String password, String confirmedPassword) {
    if (confirmedPassword.isEmpty) {
      state = emptyConfirmPassword;
      return emptyPassword;
    }

    if (password != confirmedPassword) {
      state = passwordNotIdentical;
      return passwordNotIdentical;
    }

    state = passwordConfirmed;
    return passwordConfirmed;
  }

  void reset() {
    state = passwordConfirmed;
  }
}
