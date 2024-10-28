import 'dart:developer';
import 'dart:io';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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

  // Image Picker
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

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

  Future _pickImageFromGalery() async {
    final selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    log("Image path: ${selectedImage!.path}");

    setState(() {
      _selectedImage = File(selectedImage.path);
    });
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 20),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface),
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 6,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage(AssetsAccess.defaultUserImage),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.03,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary, // Background color of the button
                          shape: BoxShape.circle, // Make it circular
                        ),
                        child: IconButton(
                          onPressed: () => _pickImageFromGalery(),
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                      ),
                    ),
                  ],
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
                    context.pushNamed(RouteNames.addressRegisterScreenRoute),
                  },
                  text: AppStrings.advance,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
