import 'dart:developer';

import 'package:bookshare/src/providers/validation_provider.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider for validation
    final emailValidateProvider = ref.watch(emailValidatorProvider);

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
                EmailTextField(
                  controller: emailController,
                  errorText: emailValidateProvider?['error'],
                ),
                const PasswordTextField(),
                const ConfirmPasswordTextField(),
                CustomButton(
                    onPressed: () => {
                          log("Sign Up: Navigate to Personal Data Register"),
                          context.pushNamed(
                              RouteNames.personalDataRegisterScreenRoute)
                          // Generating validations
                          // ref
                          //     .read(emailValidatorProvider.notifier)
                          //     .validate(emailController.text),
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
