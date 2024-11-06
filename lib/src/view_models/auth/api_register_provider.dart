//
import 'dart:developer';

import 'package:bookshare/src/data/auth/auth_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/api_response.dart';
import 'package:bookshare/src/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a loading state for the API registration process.
///
/// This `StateProvider` holds a boolean indicating whether an API registration
/// request is in progress. The initial value is `false`.
final loadingApiRegisterProvider = StateProvider<bool>((ref) => false);

/// Holds the API response for registration attempts.
///
/// This `StateProvider` stores an `ApiResponse` to represent the result of a
/// registration attempt, either success or error. The initial value is set to a
/// success response.
final acceptedApiRegisterProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.success());

/// Provider for `ApiRegisterNotifier` to manage user registration.
///
/// The `apiRegisterNotifierProvider` creates and supplies an instance of
/// `ApiRegisterNotifier` with a `Dio` instance configured for API calls,
/// including a `TokenInterceptor` to handle token management for requests.
final apiRegisterNotifierProvider =
    StateNotifierProvider<ApiRegisterNotifier, User>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    );

    // Adds token handling to the API requests via the `TokenInterceptor`.
    dio.interceptors.add(TokenInterceptor());

    // Provides an `AuthApiClient` instance to handle user registration API requests.
    return ApiRegisterNotifier(AuthApiClient(dio));
  },
);

/// A `StateNotifier` responsible for managing user registration.
///
/// The `ApiRegisterNotifier` class is responsible for handling the registration
/// functionality by communicating with the `AuthApiClient` to execute user
/// registration requests and manage the user state.
///
/// This notifier is used with Riverpod to provide user registration data and
/// state updates across the application.
class ApiRegisterNotifier extends StateNotifier<User> {
  /// API client used to handle registration requests.
  final AuthApiClient _authApiClient;

  /// Initializes the notifier with the specified `AuthApiClient` instance.
  ///
  /// [authApiClient] - Client to perform registration API requests.
  ApiRegisterNotifier(this._authApiClient) : super(User.empty());

  /// Registers a new user and updates the state with the registered user.
  ///
  /// This method takes a `User` instance, sends it to the API via the
  /// `_authApiClient`, and updates the state with the registered user.
  /// If an error occurs, it logs the error message and rethrows the exception
  /// for external handling.
  ///
  /// [user] - User instance containing registration data.
  /// Returns a `User` instance if the registration is successful.
  Future<User> registerUser(User user) async {
    try {
      final registeredUser = await _authApiClient.registerUser(user);
      state = registeredUser;
      return registeredUser;
    } catch (e) {
      log('Error registering user: $e'); // Log the error
      rethrow;
    }
  }
}
