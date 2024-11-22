import 'package:bookshare/src/data/auth_data.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/auth/api_login_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A screen that provides a user interface for logging in to the app.
///
/// The `LoginScreen` contains input fields for email and password,
/// validation logic, and a login button that integrates with the
/// authentication system using Riverpod providers.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController =
      TextEditingController(); // Controller for email input field
  final _passwordController =
      TextEditingController(); // Controller for password input field

  @override
  void dispose() {
    // Dispose of the controllers to free resources.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Validates the input fields for email and password.
  ///
  /// - Reads the `emailValidationProvider` and `passwordValidatorProvider`
  ///   to check the validity of the email and password input.
  /// - Returns `true` if both inputs are valid, otherwise `false`.
  bool _validFields() {
    final validEmail = ref
        .read(emailValidationProvider.notifier)
        .validate(_emailController.text);
    final validPass = ref
        .read(passwordValidatorProvider.notifier)
        .validate(_passwordController.text);

    return validEmail.isValid && validPass.isValid;
  }

  /// Resets the state of email and password validation providers.
  ///
  /// This method is called when navigating to a different screen to
  /// ensure validation states are cleared.
  void _resetProviders() {
    ref.read(emailValidationProvider.notifier).reset();
    ref.read(passwordValidatorProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    // Watch state from the email and password validation providers.
    final emailValidateProvider = ref.watch(emailValidationProvider);
    final passwordValidateProvider = ref.watch(passwordValidatorProvider);

    // Watch API login state.
    final loadApiLoginProv = ref.watch(loadingApiLoginProvider);
    final apiLoginProvider = ref.watch(apiLoginNotifierProvider);

    // Watch password visibility state.
    final isVisible = ref.watch(showPasswordLoginNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle), // App title in the app bar.
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SubtitleText(subtitle: AppStrings.login),
              // Login subtitle.
              // Email input field with validation error messages.
              EmailTextField(
                controller: _emailController,
                error: emailValidateProvider.message,
              ),
              // Password input field with visibility toggle and validation errors.
              PasswordTextField(
                controller: _passwordController,
                isVisible: isVisible,
                isVisibleOnPressed: () {
                  ref
                      .read(showPasswordLoginNotifierProvider.notifier)
                      .togglePasswordVisibility();
                },
                error: passwordValidateProvider.message,
              ),
              // Display a loading button while API login is in progress.
              Visibility(
                visible: !loadApiLoginProv,
                replacement: const LoadingButton(),
                child: CustomButton(
                  onPressed: () async {
                    // Validate fields before proceeding with login.
                    if (!_validFields()) return;

                    // Set loading state to true before login API call.
                    ref
                        .read(loadingApiLoginProvider.notifier)
                        .update((state) => state = true);

                    // Perform the login operation.
                    await ref.read(authDataProvider).loginUser(
                          _emailController.text,
                          _passwordController.text,
                        );

                    // If login is successful, navigate to the next screen.
                    if (!apiLoginProvider.success) return;

                    // Ensure navigation occurs safely after the current frame completes.
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      if (mounted) {
                        context.goNamed(RouteNames.loadingContentScreenRoute);
                      }
                    });
                  },
                  text: AppStrings.login, // Button text for login.
                ),
              ),
              // Display error messages if the API login fails.
              Visibility(
                visible: !apiLoginProvider.success &&
                    apiLoginProvider.message.isNotEmpty,
                child: ErrorText(text: apiLoginProvider.message),
              ),
              // Row to navigate to the signup screen if the user doesn't have an account.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      AppStrings.noAccount), // Text prompting account creation.
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 25),
                    child: TextLink(
                      text:
                          AppStrings.createAccount, // Create account link text.
                      onTap: () => {
                        _resetProviders(), // Reset validation states.
                        context.pushNamed(RouteNames
                            .signupScreenRoute), // Navigate to signup.
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
