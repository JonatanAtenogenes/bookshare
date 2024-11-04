import 'dart:developer';
import 'dart:io';

import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/providers/validation/name_validation_provider.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/view_models/user/api_upload_profile_image_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../routes/route_names.dart';
import '../../../view_models/user/api_update_personal_information_provider.dart';

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

  /// Displays a date picker dialog to select a date.
  ///
  /// This function allows the user to choose a date from a calendar interface.
  /// It sets the selected date to `_selectedDate` if the user picks a valid date.
  ///
  /// - [context]: The BuildContext used to show the date picker dialog.
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

  /// Prompts the user to pick an image from the gallery.
  ///
  /// This method uses an image picker to allow the user to select an image from
  /// their device's gallery. If an image is selected, it updates `_selectedImage`
  /// with the chosen image file.
  ///
  /// - Returns a [Future<bool>] indicating whether an image was successfully selected.
  Future<bool> _pickImageFromGallery() async {
    final selectedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
      });
      return true;
    }
    return false;
  }

  /// Uploads the selected image to the server.
  ///
  /// This function retrieves the current user from the provider and calls the
  /// upload function from the API notifier to upload the profile image.
  /// If the upload is successful, it updates the uploaded image state. If an
  /// error occurs during the upload, it updates the state with the error message.
  ///
  /// - Throws [DioException] if an error occurs during the upload process.
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
    final updatedInformationProvier = ref.watch(updatedPersonalInfoProvider);

    // TextField Providers
    final nameValidProv = ref.watch(nameValidationNotifierProvider);
    final paternalValidProv = ref.watch(paternalValidationNotifierProvider);
    final maternalValidProv = ref.watch(maternalValidationNotifierProvider);

    /// Validates the user input fields for name, paternal surname, and maternal surname.
    ///
    /// This function reads and validates each input field using its respective
    /// provider, ensuring each field meets the defined validation criteria:
    /// - First name must be non-empty, between 3 and 50 characters, and contain only alphabetic characters.
    /// - Paternal surname must meet the same criteria as the first name.
    /// - Maternal surname must meet the same criteria as the first name.
    ///
    /// Returns `true` if all fields are valid; otherwise, returns `false`.
    ///
    /// - **Returns**: `bool`
    ///   - `true` if all fields are valid
    ///   - `false` if any field fails validation
    bool validFields() {
      // Validate first name using its specific provider
      final validName = ref
          .read(nameValidationNotifierProvider.notifier)
          .validate(_nameController.text);

      // Validate paternal surname using its specific provider
      final validPaternalSurname = ref
          .read(paternalValidationNotifierProvider.notifier)
          .validate(_paternalSurnameController.text);

      // Validate maternal surname using its specific provider
      final validMaternalSurname = ref
          .read(maternalValidationNotifierProvider.notifier)
          .validate(_maternalSurnameController.text);

      // Check if all fields are valid
      return validName.isValid &&
          validPaternalSurname.isValid &&
          validMaternalSurname.isValid;
    }

    Future<void> updatePersonalInfo() async {
      final user = ref.read(currentUserProvider).copyWith(
            name: _nameController.text,
            paternalSurname: _paternalSurnameController.text,
            maternalSurname: _maternalSurnameController.text,
            birthdate: _selectedDate,
            image: uploadImageDataProvider.filePath,
          );

      try {
        await ref
            .read(apiUpdatePersonalInfoNotifierProvider.notifier)
            .updatePersonalInformation(user);
        log("Updated state: ${updatedInformationProvier.message}");

        ref.read(updatedPersonalInfoProvider.notifier).update(
              (state) => state = ApiResponse.success(),
            );
        log("Final de actualizacion");
      } on DioException catch (e) {
        //
        log("Error tryng to update information");
        ref.read(updatedPersonalInfoProvider.notifier).update(
              (state) => state = ApiResponse.error(
                e.toString(),
              ),
            );
      }
    }

    return Scaffold(
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
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 20),
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
                error: nameValidProv.message,
              ),
              CustomTextField(
                label: AppStrings.paternalSurname,
                controller: _paternalSurnameController,
                error: paternalValidProv.message,
              ),
              CustomTextField(
                label: AppStrings.maternalSurname,
                controller: _maternalSurnameController,
                error: maternalValidProv.message,
              ),
              SelectInfoImproved(
                data: AppStrings.birthdate,
                selectedData: DateFormat('dd-MM-yyyy').format(_selectedDate),
                textButton: AppStrings.select,
                onPressed: () => _selectDate(context),
              ),
              Visibility(
                visible: !updatedInformationProvier.success,
                child: ErrorText(text: updatedInformationProvier.message),
              ),
              CustomButton(
                onPressed: () async {
                  // log('Personal Data Register Screen: Navigation to Address Register Screen');
                  if (!validFields()) return;
                  await updatePersonalInfo();
                  if (!updatedInformationProvier.success) return;

                  WidgetsBinding.instance.addPostFrameCallback((callback) {
                    context.pushNamed(RouteNames.addressRegisterScreenRoute);
                  });
                },
                text: AppStrings.advance,
              )
            ],
          ),
        ),
      ),
    );
  }
}
