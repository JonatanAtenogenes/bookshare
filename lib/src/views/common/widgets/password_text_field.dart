import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          label: Text(AppStrings.password),
        ),
      ),
    );
  }
}

class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          label: Text(AppStrings.confirmPassword),
        ),
      ),
    );
  }
}
