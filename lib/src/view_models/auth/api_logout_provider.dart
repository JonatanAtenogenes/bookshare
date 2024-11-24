import 'dart:developer';

import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/auth/auth_api_client.dart';
import '../../models/response/api_response.dart';
import '../../models/user/user.dart';

/// Provides a loading state for the API logout process.
///
/// This `StateProvider` holds a boolean indicating whether an API logout
/// request is in progress. The initial value is `false`. It is used to manage
/// the loading state of the logout request.
final loadingApiLogoutProvider = StateProvider<bool>((ref) => false);

/// A `StateNotifier` responsible for managing user logout.
///
/// The `ApiLogoutNotifier` class handles user logout functionality by
/// interacting with the `AuthApiClient` to send logout requests to the backend.
/// It is used in conjunction with Riverpod for state management and updating
/// the application’s authentication state related to user logouts.
///
/// The `ApiLogoutNotifier` ensures that the logout process is handled
/// asynchronously and updates the state with the success or failure of the operation.
///
/// It includes the following functionality:
/// - Logging out the user by sending a request to the API.
/// - Updating the application state with the response of the logout request.
/// - Handling any errors that may occur during the logout process.
class ApiLogoutNotifier extends StateNotifier<AuthResponse> {
  /// API client used for handling logout requests.
  final AuthApiClient _authApiClient;

  /// Initializes the notifier with the specified `AuthApiClient` instance.
  ///
  /// [authApiClient] - Client used to perform the logout API request.
  ApiLogoutNotifier(this._authApiClient) : super(AuthResponse.error(""));

  /// Logs out the user by calling the API client and handles errors.
  ///
  /// This method interacts with the `AuthApiClient` to perform the logout operation
  /// by calling the `logoutUser` function. If the API request succeeds, it updates
  /// the state with the success status, message, and data returned from the API.
  /// If an error occurs, it logs the error message and rethrows the exception for
  /// external handling.
  ///
  /// Throws: Rethrows the error encountered during the logout request.
  Future<void> logoutUser(User user) async {
    try {
      final logoutUserResponse = await _authApiClient.logoutUser(user);
      state = state.copyWith(
        success: logoutUserResponse.success,
        message: logoutUserResponse.message,
        data: logoutUserResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for `ApiLogoutNotifier` to manage user logout functionality.
///
/// The `apiLogoutNotifierProvider` supplies an instance of `ApiLogoutNotifier`
/// configured with a `Dio` instance for making API requests. The `Dio` instance
/// includes the `TokenInterceptorInjector` to ensure that the authentication token
/// is included in the request headers during the logout process.
///
/// This provider is used to access and manage the logout state across the application.
///
/// Example usage:
/// ```dart
/// final logoutNotifier = context.read(apiLogoutNotifierProvider);
/// await logoutNotifier.logoutUser();
/// ```
final apiLogoutNotifierProvider =
    StateNotifierProvider<ApiLogoutNotifier, void>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    );

    // Adds token injection to the API requests via `TokenInterceptorInjector`.
    dio.interceptors.add(TokenInterceptorInjector());

    // Provides an `AuthApiClient` instance to handle user logout API requests.
    return ApiLogoutNotifier(AuthApiClient(dio));
  },
);
