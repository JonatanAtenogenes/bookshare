import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/widgets/text_widgets.dart';

class AddressInformationScreen extends ConsumerWidget {
  const AddressInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SubtitleText(subtitle: AppStrings.addressData),
            ),
            const SizedBox(height: 20.0),
            _buildInformationRow(
              context,
              title: AppStrings.street,
              data: currentUser.address?.street ?? '',
            ),
            _buildInformationRow(
              context,
              title: AppStrings.exteriorNumber,
              data: currentUser.address?.exteriorNumber ?? '',
            ),
            _buildInformationRow(
              context,
              title: AppStrings.postalCode,
              data: currentUser.address?.postalCode ?? '',
            ),
            _buildInformationRow(
              context,
              title: AppStrings.locality,
              data: currentUser.address?.locality ?? '',
            ),
            _buildInformationRow(
              context,
              title: AppStrings.city,
              data: currentUser.address?.city ?? '',
            ),
            _buildInformationRow(
              context,
              title: AppStrings.state,
              data: currentUser.address?.state ?? '',
            ),
            const SizedBox(height: 30.0),
            Center(
              child: CustomButton(
                onPressed: () {
                  // Navegar a la pantalla de actualización de dirección
                  Navigator.pushNamed(context, '/updateAddress');
                },
                text: 'Actualizar información de dirección',
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build rows for displaying user information
  Widget _buildInformationRow(BuildContext context,
      {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              data,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
