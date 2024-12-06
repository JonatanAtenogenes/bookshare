import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

/// Factor for horizontal padding in the text fields.
const double horizontalPaddingFactor = 25;

/// Factor for vertical padding in the text fields.
const double verticalPaddingFactor = 25;

/// A custom text field widget that allows for input of text.
///
/// This widget creates a text field with specified [label] and [controller].
class CustomTextField extends StatelessWidget {
  /// Creates a [CustomTextField].
  ///
  /// The [label] parameter is required and defines the label of the text field.
  /// The [controller] parameter is also required and manages the text input.
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.error,
  });

  /// The label for the text field.
  final String label;

  /// The controller to manage the text input.
  final TextEditingController controller;

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorText: error,
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

/// A text field specifically for number input.
///
/// This widget is designed to accept numeric input, with a specified maximum length.
class NumberTextField extends StatelessWidget {
  /// Creates a [NumberTextField].
  ///
  /// The [label] and [controller] parameters are required.
  /// The [maxLength] parameter defines the maximum number of characters allowed.
  /// The [onSubmitted] callback is optional and triggers when the user submits the input.
  const NumberTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.maxLength,
    this.onSubmitted,
    this.error,
  });

  final String label;
  final TextEditingController controller;
  final int maxLength;
  final ValueChanged<String>? onSubmitted;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
      ),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(),
        controller: controller,
        onSubmitted: onSubmitted,
        maxLength: maxLength,
        decoration: InputDecoration(
          errorText: error,
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

/// A text field that is disabled and does not allow user input.
///
/// This widget is used for displaying information that should not be edited.
class DisabledTextField extends StatelessWidget {
  /// Creates a [DisabledTextField].
  ///
  /// The [label] parameter is required. The [controller] parameter is optional.
  const DisabledTextField({
    super.key,
    required this.label,
    this.controller,
    this.error,
  });

  final String label;
  final TextEditingController? controller;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
      ),
      child: TextField(
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          errorText: error,
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

/// A text field for email input.
///
/// This widget includes validation for email format and displays an error message if provided.
class EmailTextField extends StatelessWidget {
  /// Creates an [EmailTextField].
  ///
  /// The [controller] parameter is required. The [error] parameter is optional and
  /// displays an error message if provided.
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
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
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

/// A text field for password input.
///
/// This widget includes functionality to toggle the visibility of the password input.
class PasswordTextField extends StatelessWidget {
  /// Creates a [PasswordTextField].
  ///
  /// The [controller], [isVisibleOnPressed], and [isVisible] parameters are required.
  /// The [error] parameter is optional and displays an error message if provided.
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
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
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

/// A text field for confirming password input.
///
/// This widget extends [PasswordTextField] to specifically handle confirmation of passwords.
class ConfirmPasswordTextField extends PasswordTextField {
  /// Creates a [ConfirmPasswordTextField].
  ///
  /// The [controller], [isVisibleOnPressed], and [isVisible] parameters are required.
  /// The [error] parameter is optional and displays an error message if provided.
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
        horizontal:
            MediaQuery.of(context).size.height / horizontalPaddingFactor,
        vertical: MediaQuery.of(context).size.width / verticalPaddingFactor,
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
          ),
        ),
      ),
    );
  }
}

/// A widget that displays a labeled text field.
///
/// This widget contains a label and another widget (like a text field) to create a labeled layout.
class LabeledTextField extends StatelessWidget {
  /// Creates a [LabeledTextField].
  ///
  /// The [widget] parameter is required and represents the text field or widget to be labeled.
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
