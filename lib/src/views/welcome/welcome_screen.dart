import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodels/viewmodels.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csrfProvider = ref.watch(csrfTokenProvider);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Visibility(
            visible: csrfProvider.csrfToken.isNotEmpty,
            replacement: const CircularProgressIndicator(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: TitleText(title: AppStrings.appTitle),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  child: const SubtitleText(subtitle: AppStrings.appBrand),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  child: Image.asset(
                    AssetsAccess.bookshareIcon,
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                CustomButton(
                    onPressed: () => {
                          log("Welcome Screen: Navigating to Login Screen"),
                          context.pushNamed(RouteNames.loginScreenRoute),
                        },
                    text: AppStrings.login),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(AppStrings.noAccount),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 25),
                      child: TextLink(
                        text: AppStrings.createAccount,
                        onTap: () => {
                          log("Welcome Screen: Navigating to Sign Up Screen"),
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
      ),
    );
  }
}
