import 'dart:developer';

import 'package:bookshare/src/data/auth_data.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/auth/api_register_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/enum/enums.dart';
import '../../../models/models.dart';
import '../../../view_models/user/user_provider.dart';

/// **SignUpScreen**
///
/// This screen provides the user interface for signing up a new user.
/// It includes form fields for email, password, and confirm password,
/// and integrates validation and API call logic to register a user.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

/// **_SignUpScreenState**
///
/// Manages the state and interactions of the [SignUpScreen].
class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Controllers for managing text input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validates the form fields by checking email, password, and confirm password.
  ///
  /// Returns `true` if all fields are valid, otherwise `false`.
  bool _validFields() {
    final validEmail = ref
        .read(emailValidationProvider.notifier)
        .validate(_emailController.text);
    final validPass = ref
        .read(passwordValidatorProvider.notifier)
        .validate(_passwordController.text);
    final validConfirm = ref
        .read(confirmPasswordValidatorProvider.notifier)
        .validate(_passwordController.text, _confirmPasswordController.text);
    return validEmail.isValid && validPass.isValid && validConfirm.isValid;
  }

  /// Resets validation states for all form fields.
  void _resetProviders() {
    ref.read(emailValidationProvider.notifier).reset();
    ref.read(passwordValidatorProvider.notifier).reset();
    ref.read(confirmPasswordValidatorProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    // Watch providers to manage UI state
    final emailValidProv = ref.watch(emailValidationProvider);
    final confirmPasswordValidProv =
        ref.watch(confirmPasswordValidatorProvider);
    final loadApiRegProv = ref.watch(loadingApiRegisterProvider);
    final registerNotifierProvider = ref.watch(apiRegisterNotifierProvider);

    // Watch password visibility state
    final isVisible = ref.watch(showPasswordNotifierProvider);
    final isConfirmVisible = ref.watch(showConfirmPasswordNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SubtitleText(subtitle: AppStrings.createAccount),

              // Email Text Field
              EmailTextField(
                controller: _emailController,
                error: emailValidProv.message,
              ),

              // Password Text Field
              PasswordTextField(
                controller: _passwordController,
                isVisible: isVisible,
                isVisibleOnPressed: () {
                  // Toggle password visibility
                  ref
                      .read(showPasswordNotifierProvider.notifier)
                      .togglePasswordVisibility();
                },
                error: confirmPasswordValidProv.message,
              ),

              // Confirm Password Text Field
              ConfirmPasswordTextField(
                controller: _confirmPasswordController,
                isVisible: isConfirmVisible,
                isVisibleOnPressed: () {
                  // Toggle confirm password visibility
                  ref
                      .read(showConfirmPasswordNotifierProvider.notifier)
                      .togglePasswordVisibility();
                },
                error: confirmPasswordValidProv.message,
              ),

              // Sign Up Button
              Visibility(
                visible: !loadApiRegProv,
                replacement: const LoadingButton(),
                child: CustomButton(
                  onPressed: () async {
                    log("Sign Up: Navigate to Personal Data Register");

                    // Validate fields
                    if (!_validFields()) return;

                    // Register the user
                    await ref.read(authDataProvider).registerUser(
                          _emailController.text,
                          _passwordController.text,
                        );

                    // If registration fails, do not navigate
                    if (!ref.read(apiRegisterNotifierProvider).success) return;

                    // Navigate to the personal data registration screen
                    WidgetsBinding.instance.addPostFrameCallback((callback) {
                      context.goNamed(
                        RouteNames.personalDataRegisterScreenRoute,
                      );
                    });
                  },
                  text: AppStrings.signUp,
                ),
              ),

              // Error Message (if registration fails)
              Visibility(
                visible: !registerNotifierProvider.success,
                child: ErrorText(
                  text: registerNotifierProvider.message,
                ),
              ),

              // Navigation to Login Screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(AppStrings.alreadyHaveAccount),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 25),
                    child: TextLink(
                      text: AppStrings.login,
                      onTap: () {
                        log('Sign Up Screen: Navigation to Login Screen');
                        _resetProviders(); // Reset validation providers
                        context.pushNamed(RouteNames.loginScreenRoute);
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
