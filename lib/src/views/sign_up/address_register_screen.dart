import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum Localidades { toluca, metepec, lerma }

class AddressRegisterScreen extends StatelessWidget {
  const AddressRegisterScreen({super.key});

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
                const SubtitleText(subtitle: AppStrings.addressData),
                const CustomTextField(label: AppStrings.street),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberTextField(label: AppStrings.interiorNumber),
                    ),
                    Expanded(
                      child: NumberTextField(label: AppStrings.exteriorNumber),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: NumberTextField(label: AppStrings.postalCode),
                    ),
                    Spacer(flex: 1),
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
                          dropdownMenuEntries: Localidades.values
                              .map<DropdownMenuEntry<Localidades>>(
                                  (Localidades localidad) {
                        return DropdownMenuEntry<Localidades>(
                            value: localidad, label: localidad.name);
                      }).toList()),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.city,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(label: AppStrings.city),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.state,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DisabledTextField(label: AppStrings.state),
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
