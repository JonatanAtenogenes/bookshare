import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/auth/api_logout_provider.dart';
import 'package:bookshare/src/view_models/user/api_show_user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserConfigScreen extends ConsumerStatefulWidget {
  const UserConfigScreen({super.key});

  @override
  ConsumerState<UserConfigScreen> createState() => _UserConfigScreenState();
}

class _UserConfigScreenState extends ConsumerState<UserConfigScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingUserInfo = ref.watch(loadingShowUserProvider);
    if (loadingUserInfo) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const UserInformationCard(),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const AddressInformationCard(),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            CustomButton(
                onPressed: () async {
                  await ref
                      .read(apiLogoutNotifierProvider.notifier)
                      .logoutUser();
                  WidgetsBinding.instance.addPostFrameCallback((callback) {
                    if (mounted) {
                      log("Sesion cerrada");
                      context.goNamed(RouteNames.logoutScreenRoute);
                    }
                  });
                },
                text: AppStrings.logout)
          ],
        ),
      ),
    );
  }
}
