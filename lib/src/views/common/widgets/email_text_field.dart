import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: const TextField(
        decoration: InputDecoration(
          label: Text(AppStrings.email),
        ),
      ),
    );
  }
}
