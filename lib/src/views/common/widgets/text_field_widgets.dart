import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Common Text Field
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.maxLength,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final int maxLength;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(),
        controller: controller,
        onSubmitted: onSubmitted,
        maxLength: maxLength,
        decoration: InputDecoration(
          label: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisabledTextField extends StatelessWidget {
  const DisabledTextField({
    super.key,
    required this.label,
    this.controller,
  });

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          label: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Email Text Field
class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    this.errorText,
  });

  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: const Text(AppStrings.email),
          errorText: errorText,
        ),
      ),
    );
  }
}

// Password Text Fields
class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          label: Text(AppStrings.password),
        ),
      ),
    );
  }
}

class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          label: Text(AppStrings.confirmPassword),
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Text(
            AppStrings.isbn,
            textAlign: TextAlign.end,
          ),
        ),
        Expanded(
          flex: 3,
          child: widget,
        ),
      ],
    );
  }
}
