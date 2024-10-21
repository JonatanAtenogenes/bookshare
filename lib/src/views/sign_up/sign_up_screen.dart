import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/email_text_field.dart';
import 'package:bookshare/src/views/common/widgets/password_text_field.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/widgets/text_link.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SubtitleText(subtitle: AppStrings.createAccount),
                const EmailTextField(),
                const PasswordTextField(),
                const ConfirmPasswordTextField(),
                CustomButton(
                    onPressed: () => {
                          log("Sign Up: Navigate to Personal Data Register"),
                          context.pushNamed(
                              RouteNames.personalDataRegisterScreenRoute)
                        },
                    text: AppStrings.signUp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(AppStrings.alreadyHaveAccount),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 25),
                      child: TextLink(
                        text: AppStrings.login,
                        onTap: () => {
                          log('Sign Up Screen: Navigation to Login Screen'),
                          context.pushNamed(RouteNames.loginScreenRoute),
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
