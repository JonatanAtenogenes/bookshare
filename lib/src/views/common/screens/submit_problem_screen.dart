import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class SubmitProblemScreen extends StatelessWidget {
  const SubmitProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: const Column(
        children: [
          SubtitleText(
            subtitle: AppStrings.submitProblem,
          ),
        ],
      ),
    );
  }
}
