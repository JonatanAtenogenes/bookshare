import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/api/user/user_api_client.dart';
import 'package:bookshare/src/models/response/user_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier for managing user information retrieval.
///
/// [ApiShowUserNotifier] interacts with the [UserApiClient] to fetch user data
/// from the server and updates the state with the retrieved [UserResponse].
class ApiShowUserNotifier extends StateNotifier<UserResponse> {
  final UserApiClient _userApiClient;

  /// Creates an instance of [ApiShowUserNotifier].
  ///
  /// - [_userApiClient]: The API client for making requests to the user endpoint.
  /// - [super]: Initializes the state with an error [UserResponse] containing an empty message.
  ApiShowUserNotifier(this._userApiClient) : super(UserResponse.error(""));

  /// Fetches the user data for the specified user ID.
  ///
  /// Makes an API call using the [_userApiClient] to retrieve user information.
  /// - On success: Updates the state with the fetched [UserResponse].
  /// - On failure: The error is rethrown for further handling.
  ///
  /// Parameters:
  /// - [id]: The ID of the user to fetch information for.
  ///
  /// Example usage:
  /// ```dart
  /// await notifier.showUser("user_id");
  /// ```
  Future<void> showUser(String id) async {
    try {
      final userResponse = await _userApiClient.showUser(id);
      state = state.copyWith(
        success: userResponse.success,
        message: userResponse.message,
        data: userResponse.data,
      );
    } catch (e) {
      // Re-throws any caught exceptions for further handling.
      rethrow;
    }
  }

  void updateErrorShowingUser(String message) {
    state = UserResponse.error(message);
  }
}

/// A provider for the [ApiShowUserNotifier].
///
/// This provider initializes an [ApiShowUserNotifier] instance with:
/// - A [Dio] client configured with a token interceptor for authorization.
/// - A [UserApiClient] for managing API calls.
///
/// Example usage:
/// ```dart
/// final userNotifier = ref.watch(apiShowUserNotifierProvider.notifier);
/// ```
final apiShowUserNotifierProvider =
    StateNotifierProvider<ApiShowUserNotifier, UserResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());

  return ApiShowUserNotifier(UserApiClient(dio));
});

/// A state provider for tracking the loading status of the [showUser] operation.
///
/// - [true]: Indicates that the API call is in progress.
/// - [false]: Indicates that the API call has completed or not started yet.
///
/// Example usage:
/// ```dart
/// final isLoading = ref.watch(loadingShowUserProvider);
/// ```
final loadingShowUserProvider = StateProvider<bool>((state) => false);

final apiGetUserNotifierProvider =
    StateNotifierProvider<ApiShowUserNotifier, UserResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());

  return ApiShowUserNotifier(UserApiClient(dio));
});

final loadingGetUserProvider = StateProvider<bool>((state) => false);
