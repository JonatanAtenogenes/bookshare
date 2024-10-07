import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        label: Text(AppStrings.email),
      ),
    );
  }
}
