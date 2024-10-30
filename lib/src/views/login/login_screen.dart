import 'dart:developer';

import 'package:bookshare/src/providers/validation/validation_provider.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider for email validator notifier
    final emailValidateProvider = ref.watch(emailValidatorProvider);
    final passwordValidateProvider = ref.watch(passwordValidatorProvider);

    void validateFields() {
      ref.read(emailValidatorProvider.notifier).validate(_emailController.text);
      ref
          .read(passwordValidatorProvider.notifier)
          .validate(_passwordController.text);
    }

    void resetProviders() {
      ref.read(emailValidatorProvider.notifier).reset();
      ref.read(passwordValidatorProvider.notifier).reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SubtitleText(subtitle: AppStrings.login),
              EmailTextField(
                controller: _emailController,
                error: emailValidateProvider.message,
              ),
              PasswordTextField(
                controller: _passwordController,
                error: passwordValidateProvider.message,
              ),
              CustomButton(
                onPressed: () => {
                  log('Login Screen: Navigate to Main Screen'),
                  validateFields(),
                  // context.goNamed(RouteNames.mainScreenRoute),
                },
                text: AppStrings.login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(AppStrings.noAccount),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 25),
                    child: TextLink(
                      text: AppStrings.createAccount,
                      onTap: () => {
                        log('Login Screen: Navigate to Register'),
                        resetProviders(),
                        context.pushNamed(RouteNames.signupScreenRoute),
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
