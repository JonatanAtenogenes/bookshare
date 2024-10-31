import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Title
class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Subtitle Text
class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}

// Error Text
class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}

// Text Link
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
