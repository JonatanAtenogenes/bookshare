import 'dart:developer';

import 'package:bookshare/src/models/response/api_response.dart';
import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/auth/api_login_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
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
    final emailValidateProvider = ref.watch(emailValidationProvider);
    final passwordValidateProvider = ref.watch(passwordValidatorProvider);
    // Api Login Providers
    final loadApiLoginProv = ref.watch(loadingApiLoginProvider);
    final acceptApiLoginProv = ref.watch(acceptedApiLoginProvider);
    // Password Provider
    final isVisible = ref.watch(showPasswordNotifierProvider);

    Future<bool> loginUser() async {
      try {
        ref
            .read(acceptedApiLoginProvider.notifier)
            .update((state) => ApiResponse.success());

        final user = User(
          id: "",
          email: _emailController.text,
          password: _passwordController.text,
          role: Roles.user.name,
        );

        await ref.read(apiLoginNotifierProvider.notifier).loginUser(user);
        ref
            .read(currentUserProvider.notifier)
            .update((state) => ref.read(apiLoginNotifierProvider));

        log("current user: ${ref.read(currentUserProvider)}");

        return true; // Login successful
      } on DioException catch (e) {
        String message = "An unexpected error has occurred";
        ref.read(acceptedApiLoginProvider.notifier).update(
              (state) =>
                  ApiResponse.error(e.response?.data['message'] ?? message),
            );
        log("status: ${ref.read(acceptedApiLoginProvider).success}");
        return false; // Login failed
      } finally {
        ref
            .read(loadingApiLoginProvider.notifier)
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

      return validEmail.isValid && validPass.isValid;
    }

    // bool continueWithLogin() {
    //   return ref.read(emailValidatorProvider).isValid &&
    //       ref.read(passwordValidatorProvider).isValid;
    // }

    void resetProviders() {
      ref.read(emailValidationProvider.notifier).reset();
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
                isVisible: isVisible,
                isVisibleOnPressed: () {
                  ref
                      .read(showPasswordNotifierProvider.notifier)
                      .togglePasswordVisibility();
                },
                error: passwordValidateProvider.message,
              ),
              // CustomButton(
              //   onPressed: () => {
              //     log('Login Screen: Navigate to Main Screen'),
              //     validateFields(),
              //     // context.goNamed(RouteNames.mainScreenRoute),
              //   },
              //   text: AppStrings.login,
              // ),
              Visibility(
                visible: !loadApiLoginProv,
                replacement: const LoadingButton(),
                child: CustomButton(
                  onPressed: () async {
                    if (!validFields()) return;

                    ref
                        .read(loadingApiLoginProvider.notifier)
                        .update((state) => state = true);

                    // Wait for login result
                    final success = await loginUser();

                    if (!success) return;

                    // Navigate safely after the current frame completes
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      if (mounted) {
                        context.goNamed(RouteNames.mainScreenRoute);
                      }
                    });
                  },
                  text: AppStrings.login,
                ),
              ),
              Visibility(
                visible: !acceptApiLoginProv.success &&
                    acceptApiLoginProv.message.isNotEmpty,
                child: ErrorText(text: acceptApiLoginProv.message),
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
