import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/view_models/user/api_show_user_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_strings.dart';
import '../widgets/text_widgets.dart';

class LoadingContentScreen extends ConsumerStatefulWidget {
  const LoadingContentScreen({super.key});

  @override
  ConsumerState<LoadingContentScreen> createState() =>
      _LoadingContentScreenState();
}

class _LoadingContentScreenState extends ConsumerState<LoadingContentScreen> {
  @override
  void initState() {
    super.initState();
    _showUser();
  }

  Future<void> _showUser() async {
    try {
      String id = ref.read(currentUserProvider).id;
      await ref.read(apiShowUserNotifierProvider.notifier).showUser(id);
      log("user");
      ref.read(currentUserProvider.notifier).update(
          (state) => state = ref.read(apiShowUserNotifierProvider).data!);
      log(ref.read(apiShowUserNotifierProvider).data.toString());
      if (mounted) {
        // Check if the widget is still mounted
        context.goNamed(RouteNames.mainScreenRoute);
      }
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SubtitleText(
              subtitle: AppStrings.loadingContent,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02, // Spacing
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
