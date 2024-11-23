import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user/api_show_user_provider.dart';
import '../view_models/user/user_provider.dart';

/// **userDataProvider**
///
/// Provides an instance of [UserData] for managing user-related operations.
///
/// This provider is used to interact with the [UserData] class, which handles
/// operations such as retrieving authenticated user information.
///
/// Example usage:
/// ```dart
/// final userData = ref.read(userDataProvider);
/// userData.getAuthUserInformation();
/// ```
final userDataProvider = StateProvider<UserData>((ref) {
  return UserData(ref);
});

/// **UserData**
///
/// A class responsible for managing user-related operations.
///
/// The [UserData] class uses Riverpod's state management to interact with
/// user-related providers, such as retrieving authenticated user information.
///
class UserData {
  /// Reference to Riverpod's `Ref`, used to interact with providers.
  final Ref ref;

  /// Creates an instance of [UserData].
  UserData(this.ref);

  /// **getAuthUserInformation**
  ///
  /// Retrieves the authenticated user's information and updates the `currentUserProvider` state.
  ///
  /// #### Steps:
  /// 1. Retrieves the authenticated user's ID from the `currentUserProvider`.
  /// 2. Calls the `apiShowUserNotifierProvider` to fetch user details.
  /// 3. Updates the `currentUserProvider` with the fetched user data.
  /// 4. Logs the user information for debugging purposes.
  ///
  /// #### Throws:
  /// - Any exceptions that occur during the user retrieval process.
  ///
  /// #### Example:
  /// ```dart
  /// await userData.getAuthUserInformation();
  /// ```
  Future<void> getAuthUserInformation() async {
    try {
      // Retrieve current user ID
      String id = ref.read(currentUserProvider).id;

      // Fetch user information
      await ref.read(apiShowUserNotifierProvider.notifier).showUser(id);

      // Update current user state with fetched data
      ref
          .read(currentUserProvider.notifier)
          .update((state) => ref.read(apiShowUserNotifierProvider).data!);
    } catch (e) {
      // Handle any errors
      log('Error: ${e.toString()}');
    }
  }
}
