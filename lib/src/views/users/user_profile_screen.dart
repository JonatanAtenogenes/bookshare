import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/subtitle.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SubtitleText(subtitle: AppStrings.userProfile),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 6,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      AppStrings.name,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(AppStrings.name),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      AppStrings.email,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(AppStrings.email),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      AppStrings.addressData,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(AppStrings.addressData),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
