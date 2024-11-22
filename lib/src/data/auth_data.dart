import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enum/enums.dart';
import '../models/models.dart';
import '../models/response/api_response.dart';
import '../view_models/auth/api_login_provider.dart';
import '../view_models/user/user_provider.dart';

/// Provides an instance of [AuthData] for managing authentication-related operations.
///
/// This provider allows other parts of the app to access and perform
/// authentication tasks, such as logging in a user.
final authDataProvider = Provider<AuthData>((ref) {
  return AuthData(ref);
});

/// A class responsible for managing authentication operations.
///
/// The [AuthData] class uses Riverpod's state management to perform
/// authentication tasks and update the state of the application accordingly.
class AuthData {
  /// Reference to the Riverpod's `Ref`, used to read and write state.
  final Ref ref;

  /// Creates an instance of [AuthData].
  ///
  /// - [ref]: A `Ref` object to interact with the providers.
  AuthData(this.ref);

  /// Logs in a user with the provided email and password.
  ///
  /// This method performs the following steps:
  /// 1. Initializes the state by marking the API login process as successful.
  /// 2. Creates a [User] object using the provided credentials.
  /// 3. Calls the `apiLoginNotifierProvider` to authenticate the user.
  /// 4. Updates the `currentUserProvider` with the authenticated user's data.
  /// 5. Handles errors that may occur during the login process by capturing
  ///    the error message and updating the login error state.
  /// 6. Ensures the loading state is reset regardless of the outcome.
  ///
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// Throws:
  /// - [DioException]: If an error occurs during the API request.
  Future<void> loginUser(String email, String password) async {
    try {
      // Mark the API login as successful initially.
      ref
          .read(acceptedApiLoginProvider.notifier)
          .update((state) => ApiResponse.success());

      // Create a User object with the provided credentials.
      final user = User(
        id: "",
        email: email,
        password: password,
        role: Roles.user.name,
      );

      // Perform the login operation.
      await ref.read(apiLoginNotifierProvider.notifier).loginUser(user);

      // Update the current user state with the authenticated user's data.
      ref.read(currentUserProvider.notifier).update(
          (state) => ref.read(apiLoginNotifierProvider).data!.copyWith());
    } on DioException catch (e) {
      // Handle API errors and update the login error state.
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiLoginNotifierProvider.notifier).updateErrorLogin(message);
    } finally {
      // Reset the loading state.
      ref
          .read(loadingApiLoginProvider.notifier)
          .update((state) => state = false);
    }
  }
}
