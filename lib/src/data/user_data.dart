import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user/api_show_user_provider.dart';
import '../view_models/user/user_provider.dart';

/// **userDataProvider**
///
/// Provides an instance of [UserData] for managing user-related operations.
///
/// This provider is responsible for creating and exposing an instance of the
/// [UserData] class, which handles user-related functionality such as retrieving
/// authenticated user details or fetching other users' information.
///
/// #### Example Usage:
/// ```dart
/// final userData = ref.read(userDataProvider);
/// userData.getAuthUserInformation();
/// ```
final userDataProvider = StateProvider<UserData>((ref) {
  return UserData(ref);
});

/// **UserData**
///
/// A class responsible for managing user-related operations using Riverpod.
///
/// The [UserData] class provides methods to fetch user information, either
/// for the authenticated user or other users, and updates the corresponding
/// state providers. It also handles loading states and API error responses.
///
/// #### Responsibilities:
/// - Fetch authenticated user information.
/// - Retrieve and update user details based on their ID.
/// - Manage loading states and handle errors for API interactions.
class UserData {
  /// Reference to Riverpod's `Ref`, used to interact with providers.
  final Ref ref;

  /// Creates an instance of [UserData].
  ///
  /// The constructor accepts a [Ref] object to enable interaction with
  /// the necessary Riverpod providers for user management.
  UserData(this.ref);

  /// **getAuthUserInformation**
  ///
  /// Retrieves the authenticated user's information and updates the `currentUserProvider`.
  ///
  /// #### Steps:
  /// 1. Gets the current user's ID from the `currentUserProvider`.
  /// 2. Fetches user details from the backend using `apiShowUserNotifierProvider`.
  /// 3. Updates the `currentUserProvider` with the retrieved user data.
  /// 4. Handles loading and error states appropriately.
  ///
  /// #### Throws:
  /// - Catches [DioException] for API-related errors.
  ///
  /// #### Example:
  /// ```dart
  /// await userData.getAuthUserInformation();
  /// ```
  Future<void> getAuthUserInformation() async {
    ref.read(loadingShowUserProvider.notifier).update((state) => true);
    try {
      // Retrieve the authenticated user's ID
      String id = ref.read(currentUserProvider).id;

      // Fetch user information from the API
      await ref.read(apiShowUserNotifierProvider.notifier).showUser(id);

      // Update the current user state with fetched data
      ref
          .read(currentUserProvider.notifier)
          .update((state) => ref.read(apiShowUserNotifierProvider).data!);
    } on DioException catch (e) {
      // Handle API errors and update error message in the provider
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiShowUserNotifierProvider.notifier)
          .updateErrorShowingUser(message);
    } finally {
      // Reset loading state
      ref.read(loadingShowUserProvider.notifier).update((state) => false);
    }
  }

  /// **getUserInformation**
  ///
  /// Fetches information about a specific user based on their ID and updates the `selectedUserProvider`.
  ///
  /// #### Steps:
  /// 1. Retrieves the user ID from the `bookInfoProvider` (related to the selected book).
  /// 2. Fetches user details from the backend using `apiGetUserNotifierProvider`.
  /// 3. Updates the `selectedUserProvider` with the retrieved user data.
  /// 4. Handles loading and error states appropriately.
  ///
  /// #### Throws:
  /// - Catches [DioException] for API-related errors.
  ///
  /// #### Example:
  /// ```dart
  /// await userData.getUserInformation();
  /// ```
  Future<void> getUserInformation() async {
    ref.read(loadingGetUserProvider.notifier).update((state) => true);
    try {
      // Retrieve the user ID related to the selected book
      String id = ref.read(bookInfoProvider).user.id;

      // Fetch user information from the API
      await ref.read(apiGetUserNotifierProvider.notifier).showUser(id);

      // Update the selected user state with fetched data
      ref
          .read(selectedUserProvider.notifier)
          .update((state) => ref.read(apiGetUserNotifierProvider).data!);
    } on DioException catch (e) {
      // Handle API errors and update error message in the provider
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref
          .read(apiShowUserNotifierProvider.notifier)
          .updateErrorShowingUser(message);
    } finally {
      // Reset loading state
      ref.read(loadingGetUserProvider.notifier).update((state) => false);
    }
  }
}
