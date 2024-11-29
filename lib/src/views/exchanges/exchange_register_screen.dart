import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ExchangeRegisterScreen extends StatelessWidget {
  const ExchangeRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
    );
  }
}
