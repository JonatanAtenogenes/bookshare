import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    this.error,
  });

  final TextEditingController controller;
  final String? error;

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
          prefixIcon: const Icon(FontAwesomeIcons.envelope),
          label: const Text(AppStrings.email),
          errorText: error,
        ),
      ),
    );
  }
}

// Password Text Fields
class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.isVisibleOnPressed,
    required this.isVisible,
    this.error,
  });

  final TextEditingController controller;
  final VoidCallback isVisibleOnPressed;
  final bool isVisible;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        maxLength: 20,
        decoration: InputDecoration(
          label: const Text(AppStrings.password),
          errorText: error,
          suffixIcon: IconButton(
            onPressed: isVisibleOnPressed,
            icon: !isVisible
                ? const Icon(FontAwesomeIcons.eye)
                : const Icon(FontAwesomeIcons.eyeSlash),
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordTextField extends PasswordTextField {
  const ConfirmPasswordTextField({
    super.key,
    required super.controller,
    required super.isVisibleOnPressed,
    required super.isVisible,
    super.error,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
            label: const Text(AppStrings.confirmPassword),
            errorText: error,
            suffixIcon: IconButton(
              onPressed: isVisibleOnPressed,
              icon: !isVisible
                  ? const Icon(FontAwesomeIcons.eye)
                  : const Icon(FontAwesomeIcons.eyeSlash),
            )),
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
