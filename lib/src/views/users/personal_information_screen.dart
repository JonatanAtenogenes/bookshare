import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../models/enum/enums.dart';
import '../../utils/assets_access.dart';
import '../common/widgets/text_widgets.dart';

class PersonalInformationScreen extends ConsumerWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final imageSize = MediaQuery.of(context).size.width / 3;

    log("Imagen link: ${Api.baseImageUrl}${currentUser.image}");

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
              child: SubtitleText(
                subtitle: AppStrings.userProfile,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: CircleAvatar(
                radius: imageSize / 2,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: ClipOval(
                  child: Image.network(
                    currentUser.image != null && currentUser.image!.isNotEmpty
                        ? '${Api.baseImageUrl}${currentUser.image}'
                        : AssetsAccess.defaultUserImage,
                    fit: BoxFit.cover,
                    width: imageSize,
                    height: imageSize,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AssetsAccess.defaultUserImage),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildInformationRow(
              context,
              title: AppStrings.name,
              data: currentUser.name ?? UserAttributes.name.attributeName,
            ),
            _buildInformationRow(
              context,
              title: AppStrings.paternalSurname,
              data: currentUser.paternalSurname ??
                  UserAttributes.paternalSurname.attributeName,
            ),
            _buildInformationRow(
              context,
              title: AppStrings.maternalSurname,
              data: currentUser.maternalSurname ??
                  UserAttributes.maternalSurname.attributeName,
            ),
            _buildInformationRow(
              context,
              title: AppStrings.email,
              data: currentUser.email,
            ),
            _buildInformationRow(
              context,
              title: AppStrings.birthdate,
              data: DateFormat('dd-MM-yyyy')
                  .format(currentUser.birthdate ?? DateTime.now()),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: CustomButton(
                onPressed: () {
                  ref
                      .read(personalInformationUpdateInProgress.notifier)
                      .update((update) => true);
                  context.pushNamed(RouteNames.personalDataRegisterScreenRoute);
                },
                text: 'Actualizar información personal',
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
