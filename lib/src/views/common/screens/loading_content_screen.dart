import 'package:bookshare/src/data/user_data.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_names.dart';
import '../widgets/text_widgets.dart';

/// **LoadingContentScreen**
///
/// A screen displayed while loading user data. This screen fetches
/// the authenticated user's information and navigates to the main
/// screen once the operation is complete.
///
/// ### Features:
/// - Displays a loading indicator.
/// - Fetches authenticated user data using [userDataProvider].
/// - Navigates to the main screen upon successful data retrieval.
///
/// ### Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const LoadingContentScreen()),
/// );
/// ```
class LoadingContentScreen extends ConsumerStatefulWidget {
  const LoadingContentScreen({super.key});

  @override
  ConsumerState<LoadingContentScreen> createState() =>
      _LoadingContentScreenState();
}

/// **_LoadingContentScreenState**
///
/// The state class for [LoadingContentScreen]. Handles the logic
/// for fetching user data and navigating to the main screen.
class _LoadingContentScreenState extends ConsumerState<LoadingContentScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// **_loadUserData**
  ///
  /// Fetches the authenticated user's data asynchronously and navigates
  /// to the main screen upon completion.
  ///
  /// ### Steps:
  /// 1. Calls [getAuthUserInformation] from [userDataProvider].
  /// 2. Waits for the operation to complete.
  /// 3. Navigates to the main screen if the widget is still mounted.
  ///
  /// ### Error Handling:
  /// Logs any errors that occur during the data fetching process.
  Future<void> _loadUserData() async {
    try {
      // Fetch user information
      await ref.read(userDataProvider).getAuthUserInformation();

      // Navigate to the main screen after fetching data
      if (mounted) {
        context.goNamed(RouteNames.mainScreenRoute);
      }
    } catch (e) {
      // Handle any errors during user data fetching
      debugPrint('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

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
