import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
