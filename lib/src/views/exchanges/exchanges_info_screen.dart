import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ExchangesInfoScreen extends StatelessWidget {
  const ExchangesInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
    );
  }
}
