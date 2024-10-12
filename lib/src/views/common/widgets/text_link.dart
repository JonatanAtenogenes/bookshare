import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
