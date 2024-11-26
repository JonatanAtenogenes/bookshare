import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../models/enum/enums.dart';
import '../../utils/assets_access.dart';
import '../common/widgets/show_information.dart';
import '../common/widgets/text_widgets.dart';

class PersonalInformationScreen extends ConsumerWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SubtitleText(
              subtitle: AppStrings.userProfile,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 6,
                  backgroundColor:
                      Colors.transparent, // Ensure background is transparent
                  child: ClipOval(
                    child: Image.network(
                      currentUser.image != null && currentUser.image!.isNotEmpty
                          ? '${Api.baseImageUrl}${currentUser.image}'
                          : AssetsAccess.defaultUserImage,
                      fit: BoxFit.cover,
                      // Ensure the image covers the circular area
                      width: MediaQuery.of(context).size.width / 3,
                      // Set width
                      height: MediaQuery.of(context).size.width / 3,
                      // Set height
                      loadingBuilder: (context, child, loadingProgress) =>
                          Image.asset(AssetsAccess.defaultUserImage),
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(AssetsAccess.defaultUserImage),
                    ),
                  ),
                ),
              ),
            ),
          ),
          VisualizeData(
              title: AppStrings.name,
              data: currentUser.name ?? UserAttributes.name.attributeName),
          VisualizeData(
              title: AppStrings.paternalSurname,
              data: currentUser.paternalSurname ??
                  UserAttributes.paternalSurname.attributeName),
          VisualizeData(
              title: AppStrings.maternalSurname,
              data: currentUser.maternalSurname ??
                  UserAttributes.paternalSurname.attributeName),
          VisualizeData(title: AppStrings.email, data: currentUser.email),
          VisualizeData(
              title: AppStrings.birthdate,
              data: DateFormat('dd-MM-yyyy')
                  .format(currentUser.birthdate ?? DateTime.now())),
        ],
      ),
    );
  }
}
