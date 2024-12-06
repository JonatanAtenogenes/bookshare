
import 'package:bookshare/src/api/auth/auth_api_client.dart';
import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/response/auth_response.dart';
import 'package:bookshare/src/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// **loadingApiRegisterProvider**
///
/// A `StateProvider` to track the loading state of the user registration API.
///
/// - **Type**: `StateProvider<bool>`
/// - **Default Value**: `false`
///
/// This provider holds a boolean that indicates whether the user registration
/// request is in progress (`true`) or idle (`false`). It can be used in the UI
/// to show loading indicators during API calls.
final loadingApiRegisterProvider = StateProvider<bool>((ref) => false);

/// **apiRegisterNotifierProvider**
///
/// A `StateNotifierProvider` that provides an instance of `ApiRegisterNotifier`
/// to manage user registration functionality.
///
/// - **Type**: `StateNotifierProvider<ApiRegisterNotifier, AuthResponse>`
///
/// This provider initializes the `ApiRegisterNotifier` with a `Dio` instance
/// configured for JSON-based API calls. It adds a `TokenInterceptor` to handle
/// token management for outgoing requests. The notifier manages the registration
/// state and communicates with the `AuthApiClient`.
final apiRegisterNotifierProvider =
    StateNotifierProvider<ApiRegisterNotifier, AuthResponse>(
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

/// **ApiRegisterNotifier**
///
/// A `StateNotifier` for managing user registration API calls and state updates.
///
/// This class handles user registration by communicating with the `AuthApiClient`,
/// updating the registration state, and providing error management.
///
/// - **Extends**: `StateNotifier<AuthResponse>`
/// - **Initial State**: `AuthResponse.error("")`
///
/// ### Responsibilities:
/// - Execute user registration requests.
/// - Update the `AuthResponse` state with registration success or failure data.
/// - Provide methods for managing errors and resetting the state.
///
/// This notifier is used with Riverpod to enable state management for user
/// registration across the application.
class ApiRegisterNotifier extends StateNotifier<AuthResponse> {
  /// API client used to perform registration requests.
  final AuthApiClient _authApiClient;

  /// Constructor for `ApiRegisterNotifier`.
  ///
  /// - [authApiClient]: An instance of `AuthApiClient` for API communication.
  ApiRegisterNotifier(this._authApiClient) : super(AuthResponse.error(""));

  /// **registerUser**
  ///
  /// Registers a new user by sending their information to the API.
  ///
  /// - **Parameters**:
  ///   - [user]: A `User` object containing the registration details.
  ///
  /// - **Behavior**:
  ///   - Sends a registration request via `_authApiClient`.
  ///   - Updates the state with the response from the server.
  ///   - Rethrows any exceptions for external handling.
  ///
  /// - **Returns**: `Future<void>`
  ///
  /// Example usage:
  /// ```dart
  /// final user = User(name: "John Doe", email: "john@example.com", ...);
  /// await notifier.registerUser(user);
  /// ```
  Future<void> registerUser(User user) async {
    try {
      final registerUserResponse = await _authApiClient.registerUser(user);
      state = state.copyWith(
        success: registerUserResponse.success,
        message: registerUserResponse.message,
        data: registerUserResponse.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// **updateErrorRegister**
  ///
  /// Updates the state with an error message.
  ///
  /// - **Parameters**:
  ///   - [message]: A `String` containing the error message.
  ///
  /// - **Behavior**:
  ///   - Sets the state to an error response with the provided message.
  ///
  /// Example usage:
  /// ```dart
  /// notifier.updateErrorRegister("Failed to register user");
  /// ```
  void updateErrorRegister(String message) {
    state = AuthResponse.error(message);
  }
}
