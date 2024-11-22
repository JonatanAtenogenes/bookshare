import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/auth/auth_api_client.dart';
import '../../models/response/api_response.dart';
import '../../models/models.dart';

/// Provides a loading state for the API login process.
///
/// This `StateProvider` holds a boolean value indicating whether an
/// API login request is in progress. The initial value is `false`.
final loadingApiLoginProvider = StateProvider<bool>((ref) => false);

/// Holds the API response for login attempts.
///
/// This `StateProvider` stores an `ApiResponse` instance to represent
/// the result of a login attempt, either success or error. The initial
/// value is set to an error response with an empty message.
final acceptedApiLoginProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.error(""));

/// A `StateNotifier` responsible for managing user authentication.
///
/// The `ApiLoginNotifier` class is responsible for handling the login
/// functionality. It communicates with the `AuthApiClient` to execute
/// user login requests and manage the user state.
///
/// This notifier is used with Riverpod to provide user authentication
/// api and state updates across the application.
class ApiLoginNotifier extends StateNotifier<User> {
  /// API client used to handle authentication requests.
  final AuthApiClient _authApiClient;

  /// Initializes the notifier with the specified `AuthApiClient` instance.
  ///
  /// [authApiClient] - Client to perform login API requests.
  ApiLoginNotifier(this._authApiClient) : super(User.empty());

  /// Logs in the user and updates the state with the authenticated user.
  ///
  /// This method takes a `User` instance, sends it to the API via the
  /// `_authApiClient`, and updates the state with the authenticated user.
  /// If an error occurs, it rethrows the exception for external handling.
  ///
  /// [user] - User instance containing login credentials.
  /// Returns a `User` instance if the login is successful.
  Future<void> loginUser(User user) async {
    try {
      final loggedUser = await _authApiClient.loginUser(user);
      state = loggedUser;
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for `ApiLoginNotifier` used to manage user authentication.
///
/// The `apiLoginNotifierProvider` creates and supplies an instance of
/// `ApiLoginNotifier` with a `Dio` instance configured for API calls,
/// including a `TokenInterceptor` to handle token management for requests.
final apiLoginNotifierProvider = StateNotifierProvider<ApiLoginNotifier, User>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    );

    // Adds token handling to the API requests via the `TokenInterceptor`.
    dio.interceptors.add(TokenInterceptor());

    // Provides an `AuthApiClient` instance to handle user login API requests.
    return ApiLoginNotifier(AuthApiClient(dio));
  },
);
