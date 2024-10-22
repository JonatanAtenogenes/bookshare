import 'package:bookshare/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_strings.dart';
import 'widgets.dart';

class UserInformationCard extends ConsumerWidget {
  const UserInformationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(simpleUserProvider);

    return Column(children: [
      const SubtitleText(subtitle: AppStrings.userProfile),
      CircleAvatar(
        radius: MediaQuery.of(context).size.width / 6,
        child: Image.asset(user.image),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              AppStrings.name,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(user.name),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              AppStrings.paternalSurname,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(user.paternalSurname),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              AppStrings.maternalSurname,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(user.maternalSurname),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              AppStrings.birthdate,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(DateFormat('dd-MM-yyyy').format(user.birthdate)),
          ),
        ],
      ),
      Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              AppStrings.email,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(user.email),
          ),
        ],
      ),
    ]);
  }
}
