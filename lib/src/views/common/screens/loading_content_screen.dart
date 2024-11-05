import 'package:flutter/material.dart';

import '../../../utils/app_strings.dart';
import '../widgets/text_widgets.dart';

class LoadingContentScreen extends StatefulWidget {
  const LoadingContentScreen({super.key});

  @override
  State<LoadingContentScreen> createState() => _LoadingContentScreenState();
}

class _LoadingContentScreenState extends State<LoadingContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center the loading message and progress indicator
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SubtitleText widget displaying the logging out message
            const SubtitleText(
              subtitle: AppStrings.loadingContent,
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
