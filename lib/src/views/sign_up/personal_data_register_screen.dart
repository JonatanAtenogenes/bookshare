import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalDataRegisterScreen extends StatefulWidget {
  const PersonalDataRegisterScreen({super.key});

  @override
  State<PersonalDataRegisterScreen> createState() =>
      _PersonalDataRegisterScreenState();
}

class _PersonalDataRegisterScreenState
    extends State<PersonalDataRegisterScreen> {
  final nameController = TextEditingController();
  final paternalSurnameController = TextEditingController();
  final maternalSurnameController = TextEditingController();
  final birthdateController = TextEditingController();

  // DatePicker
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    paternalSurnameController.dispose();
    maternalSurnameController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

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
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundImage:
                        const AssetImage(AssetsAccess.defaultUserImage),
                  ),
                ),
                CustomTextField(
                  label: AppStrings.name,
                  controller: nameController,
                ),
                CustomTextField(
                  label: AppStrings.paternalSurname,
                  controller: paternalSurnameController,
                ),
                CustomTextField(
                  label: AppStrings.maternalSurname,
                  controller: maternalSurnameController,
                ),
                SelectInfo(
                  data: AppStrings.birthdate,
                  textButton: AppStrings.select,
                  onPressed: () => _selectDate(context),
                ),
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
