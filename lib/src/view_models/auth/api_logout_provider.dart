import 'dart:developer';

import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth/auth_api_client.dart';
import '../../models/api/api_response.dart';

/// Provides a loading state for the API logout process.
///
/// This `StateProvider` holds a boolean indicating whether an API logout
/// request is in progress. The initial value is `false`.
final loadingApiLogoutProvider = StateProvider<bool>((ref) => false);

/// Holds the API response for logout attempts.
///
/// This `StateProvider` stores an `ApiResponse` representing the result of
/// a logout attempt, either success or error. The initial value is set to an
/// error response with an empty message.
final acceptedApiLogoutProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.error(""));

/// A `StateNotifier` responsible for managing user logout.
///
/// The `ApiLogoutNotifier` class handles user logout functionality by
/// interacting with the `AuthApiClient` to send logout requests. It is
/// used with Riverpod to manage and update the application’s authentication
/// state related to user logouts.
class ApiLogoutNotifier extends StateNotifier<void> {
  /// API client used for handling logout requests.
  final AuthApiClient _authApiClient;

  /// Initializes the notifier with the specified `AuthApiClient` instance.
  ///
  /// [authApiClient] - Client to perform logout API requests.
  ApiLogoutNotifier(this._authApiClient) : super(_authApiClient);

  /// Logs out the user by calling the API client and handles errors.
  ///
  /// This method calls `logoutUser` from `_authApiClient` to perform the
  /// logout operation. If an error occurs, it logs the error message and
  /// rethrows the exception for external handling.
  Future<void> logoutUser() async {
    try {
      await _authApiClient.logoutUser();
    } catch (e) {
      log('Error logging out user: $e'); // Log the error
      rethrow;
    }
  }
}

/// Provider for `ApiLogoutNotifier` to manage user logout functionality.
///
/// The `apiLogoutNotifierProvider` supplies an instance of `ApiLogoutNotifier`
/// configured with a `Dio` instance for API requests, including the
/// `TokenInterceptorInjector` to inject the token for authentication during
/// logout requests.
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
