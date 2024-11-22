import 'dart:developer';

import 'package:bookshare/src/data/user_data.dart';
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
    UserData().getAuthUserInformation(ref as Ref);
  }

  Future<void> _getUserBooks() async {}

  Future<void> _getListBooks() async {}

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

/*
if (mounted) {
        // Check if the widget is still mounted
        context.goNamed(RouteNames.mainScreenRoute);
      }
 */
