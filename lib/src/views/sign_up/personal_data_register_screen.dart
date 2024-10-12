import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:bookshare/src/views/common/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalDataRegisterScreen extends StatelessWidget {
  const PersonalDataRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SubtitleText(
                  subtitle: AppStrings.personalData,
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 10),
                  child: const CircleAvatar(
                    radius: 50,
                  ),
                ),
                const CustomTextField(
                  label: AppStrings.name,
                ),
                const CustomTextField(label: AppStrings.paternalSurname),
                const CustomTextField(label: AppStrings.maternalSurname),
                const CustomTextField(label: AppStrings.birthdate),
                CustomButton(
                    onPressed: () => {
                          log('Personal Data Register Screen: Navigation to Address Register Screen'),
                          context
                              .pushNamed(RouteNames.addressRegisterScreenRoute),
                        },
                    text: AppStrings.advance)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
