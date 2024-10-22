import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_strings.dart';

class AddressInformationCard extends ConsumerWidget {
  const AddressInformationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(simpleUserProvider);

    return Column(
      children: [
        SubtitleText(subtitle: AppStrings.addressData),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                AppStrings.addressData,
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(user.address.toString()),
            ),
          ],
        )
      ],
    );
  }
}
