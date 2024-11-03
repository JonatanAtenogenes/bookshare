import 'dart:developer';
import 'dart:io';

import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/viewmodels/user/api_upload_profile_image_provider.dart';
import 'package:bookshare/src/viewmodels/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../viewmodels/user/api_update_personal_information_provider.dart';

class PersonalDataRegisterScreen extends ConsumerStatefulWidget {
  const PersonalDataRegisterScreen({super.key});

  @override
  ConsumerState<PersonalDataRegisterScreen> createState() =>
      _PersonalDataRegisterScreenState();
}

class _PersonalDataRegisterScreenState
    extends ConsumerState<PersonalDataRegisterScreen> {
  final _nameController = TextEditingController();
  final _paternalSurnameController = TextEditingController();
  final _maternalSurnameController = TextEditingController();
  final _birthdateController = TextEditingController();

  // Image Picker
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // DatePicker
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1980, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<bool> _pickImageFromGallery() async {
    final selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      log("Image path: ${selectedImage.path}");

      setState(() {
        _selectedImage = File(selectedImage.path);
      });
      return true;
    } else {
      log("No image selected.");
      return false;
    }
  }

  Future<void> _uploadFileToServer() async {
    try {
      final user = ref.read(currentUserProvider);

      await ref
          .read(apiUploadImageNotifierProvider.notifier)
          .uploadProfileImage(
            File(_selectedImage!.path),
            user.id,
          );

      ref.read(uploadedImageDataProvider.notifier).update(
            (state) => state = ref.read(apiUploadImageNotifierProvider),
          );
    } on DioException catch (e) {
      ref.read(uploadedImageDataProvider.notifier).update(
            (state) =>
                state = ref.read(apiUploadImageNotifierProvider).copyWith(
                      status: false,
                      message: e.response?.data['message'],
                    ),
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _paternalSurnameController.dispose();
    _maternalSurnameController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider
    final uploadImageDataProvider = ref.watch(uploadedImageDataProvider);
    final updatePersonalInfoProv = ref.watch(
      apiUpdatePersonalInfoNotifierProvider,
    );

    Future<void> updatePersonalInfo() async {
      final user = ref.read(currentUserProvider).copyWith(
            name: _nameController.text,
            paternalSurname: _paternalSurnameController.text,
            maternalSurname: _maternalSurnameController.text,
            birthdate: _selectedDate,
            image: uploadImageDataProvider.filePath,
          );
      try {
        ref
            .read(apiUpdatePersonalInfoNotifierProvider.notifier)
            .updatePersonalInformation(user);
      } catch (e) {
        //
        log("Error tryng to update information");
      }
    }

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
                          onPressed: () async {
                            final imageSelected = await _pickImageFromGallery();
                            if (!imageSelected) return;
                            _uploadFileToServer();
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: uploadImageDataProvider.status,
                  replacement: ErrorText(
                    text: uploadImageDataProvider.message,
                  ),
                  child: Text(uploadImageDataProvider.message),
                ),
                CustomTextField(
                  label: AppStrings.name,
                  controller: _nameController,
                ),
                CustomTextField(
                  label: AppStrings.paternalSurname,
                  controller: _paternalSurnameController,
                ),
                CustomTextField(
                  label: AppStrings.maternalSurname,
                  controller: _maternalSurnameController,
                ),
                SelectInfoImproved(
                  data: AppStrings.birthdate,
                  selectedData: DateFormat('dd-MM-yyyy').format(_selectedDate),
                  textButton: AppStrings.select,
                  onPressed: () => _selectDate(context),
                ),
                CustomButton(
                  onPressed: () async {
                    log('Personal Data Register Screen: Navigation to Address Register Screen');
                    await updatePersonalInfo();
                    // context.pushNamed(RouteNames.addressRegisterScreenRoute),
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
