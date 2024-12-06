import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/auth/auth_api_client.dart';
import '../../models/models.dart';
import '../../models/response/api_response.dart';

/// Provides a loading state for the API login process.
///
/// This `StateProvider` holds a boolean value indicating whether an
/// API login request is currently being processed. The initial value is `false`.
/// It can be used to manage UI states such as showing a loading spinner during login.
final loadingApiLoginProvider = StateProvider<bool>((ref) => false);

/// Holds the API response for login attempts.
///
/// This `StateProvider` stores an instance of `ApiResponse` that represents
/// the result of a login attempt. It will hold a success or error response,
/// and the initial state is set to an error response with an empty message.
final acceptedApiLoginProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.error(""));

// A `StateNotifier` responsible for managing user authentication.
///
/// The `ApiLoginNotifier` is in charge of handling the login process. It communicates
/// with the `AuthApiClient` to execute user login requests, updates the authentication
/// state, and handles API responses. It uses Riverpod's state management to share the login
/// state across the application.
///
/// This notifier provides an interface for calling the login API and updating the UI
/// with the result (either success or error).
class ApiLoginNotifier extends StateNotifier<AuthResponse> {
  /// API client used to handle authentication requests.
  final AuthApiClient _authApiClient;

  /// Initializes the notifier with the specified `AuthApiClient` instance.
  ///
  /// [authApiClient] - The API client used to perform login requests.
  ApiLoginNotifier(this._authApiClient) : super(AuthResponse.error(""));

  /// Logs in the user and updates the state with the authenticated user's data.
  ///
  /// This method takes a `User` instance, sends it to the backend API using the
  /// `_authApiClient`'s `loginUser` method, and updates the state with the authentication result.
  /// If the login is successful, the user's data is returned and stored in the state.
  ///
  /// If an error occurs during the login request, it will be caught and rethrown for
  /// external handling.
  ///
  /// [user] - The `User` instance containing the login credentials (email and password).
  /// Returns a `Future` that completes when the login attempt finishes.
  Future<void> loginUser(User user) async {
    try {
      // Making the API call to login the user.
      final loginUserResponse = await _authApiClient.loginUser(user);

      // Update the state based on the API response.
      state = state.copyWith(
        success: loginUserResponse.success,
        message: loginUserResponse.message,
        data: loginUserResponse.data,
      );
    } catch (e) {
      // Rethrow the error to be handled outside this method.
      rethrow;
    }
  }

  /// Updates the state with an error message if the login fails.
  ///
  /// This method is used to set the `AuthResponse` state to an error response
  /// with a custom error message. This is typically used when there's an API error
  /// or validation failure during the login process.
  ///
  /// [message] - The error message to set in the state.
  void updateErrorLogin(String message) {
    state = AuthResponse.error(message);
  }
}

/// Provider for the `ApiLoginNotifier`, used to manage user authentication state.
///
/// The `apiLoginNotifierProvider` creates and supplies an instance of `ApiLoginNotifier`
/// using a configured `Dio` instance. The `Dio` instance includes an `AuthApiClient`
/// to handle login API requests and a `TokenInterceptor` to manage token-based authentication.
///
/// The provider can be used to manage the login state and trigger login actions
/// across the app by interacting with the `ApiLoginNotifier`.
final apiLoginNotifierProvider =
    StateNotifierProvider<ApiLoginNotifier, AuthResponse>(
  (ref) {
    // Create a Dio instance with JSON content type for API requests.
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    );

    // Add the token interceptor to handle token management in API requests.
    dio.interceptors.add(TokenInterceptor());

    // Create and return an instance of ApiLoginNotifier with the Dio instance.
    return ApiLoginNotifier(AuthApiClient(dio));
  },
);
