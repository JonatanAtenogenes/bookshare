import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_names.dart';

// LogoutScreen widget, a StatefulWidget for managing user logout
class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

// State class for LogoutScreen
class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    // Delay navigation to the welcome screen for 1 second
    Future.delayed(const Duration(seconds: 1), () {
      // After delay, navigate to welcome screen
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        context.goNamed(RouteNames.welcomeScreenRoute);
      });
    });
    super.initState(); // Call the superclass method
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the logout screen
    return Scaffold(
      body: Center(
        // Center the loading message and progress indicator
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SubtitleText widget displaying the logging out message
            const SubtitleText(
              subtitle: AppStrings.loggingOut,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02, // Spacing
            ),
            // Circular progress indicator to show ongoing action
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
