import 'dart:developer';

import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/auth/api_register_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/models.dart';
import '../../../view_models/user/user_provider.dart';

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
    final emailValidProv = ref.watch(emailValidationProvider);
    final passwordValidProv = ref.watch(passwordValidatorProvider);
    final confirmPasswordValidProv =
        ref.watch(confirmPasswordValidatorProvider);
    final acceptApiRegProv = ref.watch(acceptedApiRegisterProvider);
    final loadApiRegProv = ref.watch(loadingApiRegisterProvider);
    // Password Provider
    final isVisible = ref.watch(showPasswordNotifierProvider);
    final isConfirmVisible = ref.watch(showConfirmPasswordNotifierProvider);

    Future<bool> registerUser() async {
      try {
        ref
            .read(acceptedApiRegisterProvider.notifier)
            .update((state) => ApiResponse.success());

        final user = User(
          id: "",
          email: _emailController.text,
          password: _passwordController.text,
          role: Roles.user.name,
        );

        await ref.read(apiRegisterNotifierProvider.notifier).registerUser(user);
        ref
            .read(currentUserProvider.notifier)
            .update((state) => state = ref.read(apiRegisterNotifierProvider));

        ref
            .read(loadingApiRegisterProvider.notifier)
            .update((state) => state = false);

        return true;
      } on DioException catch (e) {
        log('error en sign up screen ${e.toString()}');
        String errorMessage = 'An unexpected error occurred.';

        if (e.type == DioExceptionType.connectionError) {
          log('error connection error');

          ref
              .read(acceptedApiRegisterProvider.notifier)
              .update((state) => ApiResponse.error(e.message ?? errorMessage));
        } else if (e.response!.statusCode == 422) {
          log("otro error 422");
          log(e.response!.data['errors'].toString());
          ref.read(acceptedApiRegisterProvider.notifier).update((state) =>
              ApiResponse.error(e.response!.data['errors'].toString()));
        } else {
          log("otro error");
        }
        return false; // Register failed
      } finally {
        ref
            .read(loadingApiRegisterProvider.notifier)
            .update((state) => state = false);
      }
    }

    bool validFields() {
      final validEmail = ref
          .read(emailValidationProvider.notifier)
          .validate(_emailController.text);
      final validPass = ref
          .read(passwordValidatorProvider.notifier)
          .validate(_passwordController.text);
      final validConfirm = ref
          .read(confirmPasswordValidatorProvider.notifier)
          .vaidate(_passwordController.text, _confirmPasswordController.text);
      return validEmail.isValid && validPass.isValid && validConfirm.isValid;
    }

    void resetProviders() {
      ref.read(emailValidationProvider.notifier).reset();
      ref.read(passwordValidatorProvider.notifier).reset();
      ref.read(confirmPasswordValidatorProvider.notifier).reset();
    }

    // bool continueWithRegister() {
    //   return ref.read(emailValidatorProvider).isValid &&
    //       ref.read(passwordValidatorProvider).isValid &&
    //       ref.read(confirmPasswordValidatorProvider).isValid;
    // }

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
                  error: emailValidProv.message,
                ),
                PasswordTextField(
                  controller: _passwordController,
                  isVisible: isVisible,
                  isVisibleOnPressed: () {
                    ref
                        .read(showPasswordNotifierProvider.notifier)
                        .togglePasswordVisibility();
                  },
                  error: confirmPasswordValidProv.message,
                ),
                ConfirmPasswordTextField(
                  controller: _confirmPasswordController,
                  isVisible: isConfirmVisible,
                  isVisibleOnPressed: () {
                    ref
                        .read(showConfirmPasswordNotifierProvider.notifier)
                        .togglePasswordVisibility();
                  },
                  error: confirmPasswordValidProv.message,
                ),
                Visibility(
                  visible: !loadApiRegProv,
                  replacement: const LoadingButton(),
                  child: CustomButton(
                    onPressed: () async {
                      log("Sign Up: Navigate to Personal Data Register");
                      if (!validFields()) return;

                      ref
                          .read(loadingApiRegisterProvider.notifier)
                          .update((state) => state = true);

                      final success = await registerUser();

                      if (!success) return;

                      WidgetsBinding.instance.addPostFrameCallback((duration) {
                        context.goNamed(
                            RouteNames.personalDataRegisterScreenRoute);
                      });
                    },
                    text: AppStrings.signUp,
                  ),
                ),
                Visibility(
                  visible: !acceptApiRegProv.success,
                  child: ErrorText(text: acceptApiRegProv.message),
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