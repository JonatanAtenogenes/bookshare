import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/validation/password_validation.dart';

final confirmPasswordValidatorProvider = StateNotifierProvider.autoDispose<
    ConfirmPasswordValidatorNotifier,
    PasswordValidation>((ref) => ConfirmPasswordValidatorNotifier());

class ConfirmPasswordValidatorNotifier
    extends StateNotifier<PasswordValidation> {
  ConfirmPasswordValidatorNotifier() : super(passwordConfirmed);

  Validation validate(String password, String confirmedPassword) {
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
