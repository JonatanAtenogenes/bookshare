import 'dart:developer';

import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/viewmodels/auth/register_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
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
    final errorRegistrationProvider = ref.watch(errorRegisterProvider);
    final loadingRegistrationProvider = ref.watch(loadingRegisterProvider);

    void registerUser() async {
      try {
        ref
            .read(errorRegisterProvider.notifier)
            .update((state) => ApiResponse.success());

        await ref.read(registerNotifierProvider.notifier).registerUser(
              User(
                id: "",
                email: _emailController.text,
                password: _passwordController.text,
                role: Roles.user.name,
              ),
            );
        ref
            .read(loadingRegisterProvider.notifier)
            .update((_) => false); // Desactivar loading
      } on DioException catch (e) {
        log('error en sign up screen ${e.toString()}');
        String errorMessage = 'An unexpected error occurred.';
        if (e.type == DioExceptionType.connectionError) {
          log('error connection error');
          ref
              .read(errorRegisterProvider.notifier)
              .update((state) => ApiResponse.error(e.message ?? errorMessage));
        } else if (e.response!.statusCode == 422) {
          log("otro error 422");
          log(e.response!.data['errors'].toString());
          ref.read(errorRegisterProvider.notifier).update((state) =>
              ApiResponse.error(e.response!.data['errors'].toString()));
        } else {
          log("otro error");
        }
      } finally {
        ref
            .read(loadingRegisterProvider.notifier)
            .update((_) => false); // Desactivar loading
      }
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
                Visibility(
                  visible: !loadingRegistrationProvider,
                  replacement: const LoadingButton(),
                  child: CustomButton(
                    onPressed: () {
                      log("Sign Up: Navigate to Personal Data Register");
                      validateFields();
                      if (continueWithRegister()) {
                        ref
                            .read(loadingRegisterProvider.notifier)
                            .update((_) => true); // Activar loading
                        registerUser();
                      }
                      if (!errorRegistrationProvider.hasError) {
                        context.goNamed(
                            RouteNames.personalDataRegisterScreenRoute);
                      }
                    },
                    text: AppStrings.signUp,
                  ),
                ),
                Visibility(
                  visible: errorRegistrationProvider.hasError,
                  child: ErrorText(text: errorRegistrationProvider.message),
                ),
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
