import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/email_text_field.dart';
import 'package:bookshare/src/views/common/widgets/password_text_field.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/widgets/text_link.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          leading: IconButton(
            onPressed: () => {
              context.pushNamed(RouteNames.welcomeScreenRoute),
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SubtitleText(subtitle: AppStrings.signUp),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const EmailTextField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const PasswordTextField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const ConfirmPasswordTextField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      AppStrings.signUp,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(AppStrings.alreadyHaveAccount),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => {
                          context.pushNamed(RouteNames.loginScreenRoute),
                        },
                        child: const TextLink(text: AppStrings.login),
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
