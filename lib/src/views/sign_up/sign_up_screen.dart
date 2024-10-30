import 'dart:developer';

import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/viewmodels/auth/register_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/models.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider for validation
    final emailValidateProvider = ref.watch(emailValidatorProvider);
    final passwordValidateProvider = ref.watch(passwordValidatorProvider);
    final confirmPasswordValidateProvider =
        ref.watch(confirmPasswordValidatorProvider);

    void registerUser() async {
      final user = User(
        id: "",
        email: _emailController.text,
        password: _passwordController.text,
        role: Roles.user.name,
      );

      await ref.read(registerNotifierProvider.notifier).registerUser(user);
    }

    void validateFields() {
      ref.read(emailValidatorProvider.notifier).validate(_emailController.text);
      ref
          .read(passwordValidatorProvider.notifier)
          .validate(_passwordController.text);
      ref
          .read(confirmPasswordValidatorProvider.notifier)
          .vaidate(_passwordController.text, _confirmPasswordController.text);
    }

    void resetProviders() {
      ref.read(emailValidatorProvider.notifier).reset();
      ref.read(passwordValidatorProvider.notifier).reset();
      ref.read(confirmPasswordValidatorProvider.notifier).reset();
    }

    bool continueWithRegister() {
      return ref.read(emailValidatorProvider).isValid &&
          ref.read(passwordValidatorProvider).isValid &&
          ref.read(confirmPasswordValidatorProvider).isValid;
    }

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
                  controller: _emailController,
                  error: emailValidateProvider.message,
                ),
                PasswordTextField(
                  controller: _passwordController,
                  error: passwordValidateProvider.message,
                ),
                ConfirmPasswordTextField(
                  controller: _confirmPasswordController,
                  error: confirmPasswordValidateProvider.message,
                ),
                CustomButton(
                    onPressed: () => {
                          log("Sign Up: Navigate to Personal Data Register"),
                          validateFields(),
                          if (continueWithRegister())
                            {
                              registerUser(),
                            }
                          // context.pushNamed(
                          //     RouteNames.personalDataRegisterScreenRoute)
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
                          resetProviders(),
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
