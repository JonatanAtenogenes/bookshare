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

//------------------------------------------------------------------------------

/// A `StateNotifier` responsible for managing password visibility state.
///
/// The `PasswordVisibilityNotifier` class allows toggling and resetting
/// the visibility of a password, providing a boolean state to indicate
/// whether the password is visible or hidden.
class PasswordVisibilityNotifier extends StateNotifier<bool> {
  /// Initializes the notifier with the specified initial visibility state.
  ///
  /// [state] - Initial state representing whether the password is visible (true)
  /// or hidden (false).
  PasswordVisibilityNotifier(super.state);

  /// Toggles the current password visibility state.
  ///
  /// If the password is currently hidden, it will become visible,
  /// and vice versa.
  void togglePasswordVisibility() {
    state = !state;
  }

  /// Resets the password visibility state to hidden (false).
  void reset() {
    state = false;
  }
}

/// Provider for managing password visibility in user input fields.
///
/// The `showPasswordNotifierProvider` provides an instance of
/// `PasswordVisibilityNotifier`, initialized with the initial state
/// of password visibility set to hidden (false). This provider is
/// set to auto-dispose when no longer needed.
final showPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<PasswordVisibilityNotifier, bool>(
        (ref) => PasswordVisibilityNotifier(false));

/// Provider for managing password visibility on the login screen.
///
/// The `showPasswordLoginNotifierProvider` provides an instance of
/// `PasswordVisibilityNotifier`, initialized with the initial state
/// of password visibility set to hidden (false). This provider is
/// set to auto-dispose when no longer needed.
final showPasswordLoginNotifierProvider =
    StateNotifierProvider.autoDispose<PasswordVisibilityNotifier, bool>(
        (ref) => PasswordVisibilityNotifier(false));

/// Provider for managing confirmation password visibility in user input fields.
///
/// The `showConfirmPasswordNotifierProvider` provides an instance of
/// `PasswordVisibilityNotifier`, initialized with the initial state
/// of confirmation password visibility set to hidden (false). This
/// provider is set to auto-dispose when no longer needed.
final showConfirmPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<PasswordVisibilityNotifier, bool>(
        (ref) => PasswordVisibilityNotifier(false));
