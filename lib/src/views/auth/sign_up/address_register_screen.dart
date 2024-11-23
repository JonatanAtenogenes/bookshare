import 'dart:developer';

import 'package:bookshare/src/models/response/api_response.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/address/api_localities_provider.dart';
import 'package:bookshare/src/view_models/user/api_update_address_information_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/address/locality.dart';
import '../../../models/models.dart';
import '../../../providers/validation/input_validation_provider.dart';
import '../../../routes/route_names.dart';

class AddressRegisterScreen extends ConsumerStatefulWidget {
  const AddressRegisterScreen({super.key});

  @override
  ConsumerState<AddressRegisterScreen> createState() =>
      _AddressRegisterScreenState();
}

class _AddressRegisterScreenState extends ConsumerState<AddressRegisterScreen> {
  final _streetController = TextEditingController();
  final _intNumberController = TextEditingController();
  final _extNumberController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _localityController = TextEditingController();

  @override
  void dispose() {
    _streetController.dispose();
    _intNumberController.dispose();
    _extNumberController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _localityController.dispose();
    super.dispose();
  }

  Future<void> _retrieveLocalities() async {
    try {
      await ref
          .read(apiLocalitiesNotifierProvider.notifier)
          .retrieveLocalities(int.parse(_postalCodeController.text));

      ref.read(localitiesInfoRetrievedProvider.notifier).update(
            (state) => state = ApiResponse.success(),
          );
    } on DioException catch (e) {
      ref.read(localitiesInfoRetrievedProvider.notifier).update(
            (state) => state = ApiResponse.error(e.response?.data['message']),
          );
    }
  }

  /// Validates all the fields required for an address.
  ///
  /// This method checks the validity of the following fields:
  /// - Street
  /// - Interior Number
  /// - Exterior Number
  /// - Postal Code
  /// - Locality
  /// - City
  /// - State
  ///
  /// It uses the respective validation providers for each field to ensure that
  /// they meet the necessary criteria. The method logs the validation process
  /// and returns `true` if all fields are valid; otherwise, it returns `false`.
  ///
  /// Returns:
  /// - `bool`: `true` if all fields are valid, `false` otherwise.
  bool validFields() {
    // Validate street using its specific provider
    final validStreet = ref
        .read(streetValidationNotifierProvider.notifier)
        .validateText(_streetController.text);

    // Validate exterior number using its specific provider
    final validExteriorNumber = ref
        .read(exteriorNumberValidationNotifierProvider.notifier)
        .validateNumber(
            _extNumberController.text, 1); // Adjust minimum as needed

    // Validate postal code using its specific provider
    final validPostalCode = ref
        .read(postalCodeValidationNotifierProvider.notifier)
        .validateNumber(_postalCodeController.text,
            5); // Assuming postal codes have a minimum length of 5

    // Validate locality using its specific provider
    final validLocality = ref
        .read(localityValidationNotifierProvider.notifier)
        .validateText(_localityController.text);

    // Validate city using its specific provider
    final validCity = ref
        .read(cityValidationNotifierProvider.notifier)
        .validateText(_cityController.text);

    // Validate state using its specific provider
    final validState = ref
        .read(stateValidationNotifierProvider.notifier)
        .validateText(_stateController.text);

    // Check if all fields are valid
    return validStreet.isValid &&
        //validInteriorNumber.isValid &&
        validExteriorNumber.isValid &&
        validPostalCode.isValid &&
        validLocality.isValid &&
        validCity.isValid &&
        validState.isValid;
  }

  @override
  Widget build(BuildContext context) {
    // Provider
    final localitiesApiProvider = ref.watch(apiLocalitiesNotifierProvider);
    // Field Control Providers
    final streetProvider = ref.watch(streetValidationNotifierProvider);
    final extNumberProvider =
        ref.watch(exteriorNumberValidationNotifierProvider);
    final postalCodeProvider = ref.watch(postalCodeValidationNotifierProvider);
    final cityProvider = ref.watch(cityValidationNotifierProvider);
    final stateProvider = ref.watch(stateValidationNotifierProvider);
    // Form Control Provider
    final updatedAddressInfoProv = ref.watch(updatedAddressInfoProvider);
    final localitiesInfoProvider = ref.watch(localitiesInfoRetrievedProvider);

    /// Validates the postal code entered by the user.
    ///
    /// This function uses the `postalCodeValidationNotifierProvider` to
    /// validate the postal code, ensuring it meets a specified length requirement.
    ///
    /// Returns `true` if the postal code is valid; otherwise, `false`.
    ///
    /// - Uses the `validateNumber` method with a minimum required length of 5.
    bool validPostalCode() {
      final postalCodeValidation = ref
          .read(postalCodeValidationNotifierProvider.notifier)
          .validateNumber(_postalCodeController.text, 5);
      return postalCodeValidation.isValid;
    }

    /// Updates the user's address information.
    ///
    /// This function gathers address api from input controllers, creates an
    /// [Address] object, and updates the current user's address information by
    /// using the `apiUpdateAddressInfoNotifierProvider` provider to send a
    /// request to the server. Upon a successful update, it sets the state
    /// in `updatedPersonalInfoProvider` to indicate success. If an error
    /// occurs, it captures the error and updates the state with an error message.
    ///
    /// Returns a [Future] that completes when the address update process is finished.
    Future<void> updateAddressInformation() async {
      // Create an Address object with api from input controllers
      final address = Address(
        street: _streetController.text,
        exteriorNumber: _extNumberController.text,
        interiorNumber: _intNumberController.text,
        postalCode: _postalCodeController.text,
        locality: _localityController.text,
        city: _cityController.text,
        state: _stateController.text,
      );

      // Update the current user's address
      User user = ref.read(currentUserProvider).copyWith(address: address);

      try {
        // Send update request to the server
        await ref
            .read(apiUpdateAddressInfoNotifierProvider.notifier)
            .updateAddressInformation(user);

        // Update personal info state to success if the request succeeds
        ref.read(updatedAddressInfoProvider.notifier).update(
              (state) => state = ApiResponse.success(),
            );
      } on DioException catch (e) {
        log("Error trying updating address");
        log(e.response?.data['message']);
        // Capture and update personal info state with an error message if the request fails
        ref.read(updatedAddressInfoProvider.notifier).update(
              (state) => state = ApiResponse.error(e.response?.data['message']),
            );
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
                const SubtitleText(subtitle: AppStrings.addressData),
                CustomTextField(
                  label: AppStrings.street,
                  controller: _streetController,
                  error: streetProvider.message,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberTextField(
                        label: AppStrings.interiorNumber,
                        maxLength: 5,
                        controller: _intNumberController,
                      ),
                    ),
                    Expanded(
                      child: NumberTextField(
                        label: AppStrings.exteriorNumber,
                        maxLength: 5,
                        controller: _extNumberController,
                        error: extNumberProvider.message,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: NumberTextField(
                        label: AppStrings.postalCode,
                        maxLength: 5,
                        error: postalCodeProvider.message,
                        controller: _postalCodeController,
                        onSubmitted: (String postalCode) async {
                          if (!validPostalCode()) return;
                          await _retrieveLocalities();
                        },
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
                Visibility(
                  visible: !localitiesInfoProvider.success,
                  child: ErrorText(text: localitiesInfoProvider.message),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(AppStrings.locality),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu(
                        enabled: localitiesInfoProvider.success,
                        width: MediaQuery.of(context).size.width * 0.55,
                        controller: _localityController,
                        onSelected: (Locality? locality) {
                          _stateController.text = locality!.state;
                          _cityController.text = locality.city;
                        },
                        dropdownMenuEntries: localitiesApiProvider.localities
                            .map<DropdownMenuEntry<Locality>>(
                          (Locality locality) {
                            return DropdownMenuEntry<Locality>(
                              value: locality,
                              label: locality.locality,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.city,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(
                        label: AppStrings.city,
                        controller: _cityController,
                        error: cityProvider.message,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.state,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(
                        label: AppStrings.state,
                        controller: _stateController,
                        error: stateProvider.message,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !updatedAddressInfoProv.success,
                  child: ErrorText(text: updatedAddressInfoProv.message),
                ),
                CustomButton(
                  onPressed: () async {
                    if (!validFields()) return;
                    await updateAddressInformation();
                    if (!updatedAddressInfoProv.success) return;

                    Future.delayed(const Duration(milliseconds: 500));

                    WidgetsBinding.instance.addPostFrameCallback((callback) {
                      context.goNamed(RouteNames.loadingContentScreenRoute);
                    });
                  },
                  text: AppStrings.advance,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
