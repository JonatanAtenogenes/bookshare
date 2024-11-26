import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/widgets/show_information.dart';
import '../common/widgets/text_widgets.dart';

class AddressInformationScreen extends ConsumerWidget {
  const AddressInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SubtitleText(subtitle: AppStrings.addressData),
          ),
          VisualizeData(
              title: AppStrings.street, data: currentUser.address!.street),
          VisualizeData(
              title: AppStrings.exteriorNumber,
              data: currentUser.address!.exteriorNumber),
          VisualizeData(
              title: AppStrings.postalCode,
              data: currentUser.address!.postalCode),
          VisualizeData(
              title: AppStrings.locality, data: currentUser.address!.locality),
          VisualizeData(
              title: AppStrings.city, data: currentUser.address!.city),
          VisualizeData(
              title: AppStrings.state, data: currentUser.address!.state),
        ],
      ),
    );
  }
}
