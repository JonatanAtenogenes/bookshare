import 'package:flutter/material.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.inversePrimary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colorScheme.error.withOpacity(0.4),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Use colorScheme.primary for the background color
          backgroundColor: colorScheme.primary,
          // Use colorScheme.onPrimary for the text color
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    // Light Theme
    primary: Color(0xFF1976D2),
    // Medium blue
    onPrimary: Colors.white,
    // White for elements on top of primary

    secondary: Color(0xFF757575),
    // Medium gray
    onSecondary: Colors.white,
    // White for elements on top of secondary

    error: Colors.redAccent,
    // Red for error messages
    onError: Colors.white,
    // White for text on error color

    surface: Color(0xFFF3F4F6),
    // Light gray background
    onSurface: Colors.black,
    // Black for elements on top of background

    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    // Dark Theme
    primary: Color(0xFF90CAF9),
    // Light blue
    onPrimary: Colors.black,
    // Black for elements on top of primary

    secondary: Color(0xFFB0BEC5),
    // Light gray
    onSecondary: Colors.black,
    // Black for elements on top of secondary

    error: Colors.redAccent,
    // Light red for errors
    onError: Colors.black,
    // Black for text on error color

    surface: Color(0xFF1E1E1E),
    // Dark gray for elevated surfaces
    onSurface: Colors.white,
    // White for elements on top of surfaces

    brightness: Brightness.dark,
  );
}
