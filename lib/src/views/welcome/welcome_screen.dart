import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:bookshare/src/views/common/widgets/text_link.dart';
import 'package:bookshare/src/views/common/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Center(
                child: TitleText(title: AppStrings.appTitle),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                child: const SubtitleText(subtitle: AppStrings.appBrand),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
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
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 25),
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
    );
  }
}
