import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/address/api_localities_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/address/locality.dart';

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
      log("Trying to get localities with postal code: ${_postalCodeController.text}");
      ref
          .read(apiLocalitiesNotifierProvider.notifier)
          .retrieveLocalities(int.parse(_postalCodeController.text));

      log("Exit?");
    } catch (e) {
      //
      log("Error retrieving localities. ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider
    final localities = ref.watch(apiLocalitiesNotifierProvider);
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
                        controller: _postalCodeController,
                        onSubmitted: (String postalCode) async {
                          await _retrieveLocalities();
                        },
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
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
                        controller: _localityController,
                        onSelected: (Locality? l) {
                          log('Selected State: ${l?.state}');
                          _stateController.text = l!.state;
                          _cityController.text = l.city;
                        },
                        dropdownMenuEntries: localities.localities
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
                      ),
                    ),
                  ],
                ),
                CustomButton(
                    onPressed: () => {
                          log('Address Screen: Navigate to Main Screen'),
                          context.goNamed(RouteNames.mainScreenRoute),
                        },
                    text: AppStrings.advance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
