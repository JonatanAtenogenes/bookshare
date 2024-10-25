import 'dart:developer';

import 'package:bookshare/src/providers/validation_provider.dart';
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
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider for email validator notifier
    final emailValidateProvider = ref.watch(emailValidatorProvider);

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
                controller: emailController,
                errorText: emailValidateProvider?['error'],
              ),
              const PasswordTextField(),
              CustomButton(
                onPressed: () => {
                  log('Login Screen: Navigate to Main Screen'),
                  ref
                      .read(emailValidatorProvider.notifier)
                      .validate(emailController.text),
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
                        ref.read(emailValidatorProvider.notifier).reset(),
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
