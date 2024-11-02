import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider<bool>((ref) => false);

// Key for saving theme preference
// const String _themePreferenceKey = 'isDarkTheme';

// // Notifier that manages the theme state
// class ThemeNotifier extends StateNotifier<ThemeMode> {
//   ThemeNotifier() : super(ThemeMode.light) {
//     _loadTheme(); // Load saved theme preference on initialization
//   }

//   // Toggle theme and save the new preference
//   Future<void> toggleTheme() async {
//     final isCurrentlyDark = state == ThemeMode.dark;
//     final newTheme = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
//     state = newTheme;

//     // Save the user’s preference
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themePreferenceKey, newTheme == ThemeMode.dark);
//   }

//   // Load the saved theme preference
//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool(_themePreferenceKey) ?? false;
//     state = isDark ? ThemeMode.dark : ThemeMode.light;
//   }
// }

// // Provider for the ThemeNotifier
// final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
//   (ref) => ThemeNotifier(),
// );

class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier(super.state);

  void togglePasswordVisibility() {
    state = !state;
  }

  void reset() {
    state = false;
  }
}

final showPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<PasswordVisibilityNotifier, bool>(
        (ref) => PasswordVisibilityNotifier(false));

final showConfirmPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<PasswordVisibilityNotifier, bool>(
        (ref) => PasswordVisibilityNotifier(false));
