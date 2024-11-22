import 'package:bookshare/src/api/interceptors/token_interceptor.dart';
import 'package:bookshare/src/api/user/user_api_client.dart';
import 'package:bookshare/src/models/response/user_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier for managing user information retrieval.
///
/// This class uses the [UserApiClient] to fetch user api from the server
/// and updates the state with the retrieved [UserResponse].
class ApiShowUserNotifier extends StateNotifier<UserResponse> {
  final UserApiClient _userApiClient;

  /// Creates an instance of [ApiShowUserNotifier].
  ///
  /// Initializes the notifier with a [UserApiClient] and sets the initial state
  /// to a successful [UserResponse] with an empty string.
  ApiShowUserNotifier(this._userApiClient) : super(UserResponse.success(""));

  /// Fetches the user api for the specified user ID.
  ///
  /// Makes an API call to retrieve user information from the server.
  /// On success, the state is updated with the fetched [UserResponse].
  ///
  /// Throws an error if the API call fails.
  ///
  /// - Parameter [id]: The ID of the user to fetch information for.
  Future<void> showUser(String id) async {
    try {
      final userResponse = await _userApiClient.showUser(id);
      state = state.copyWith(
        success: userResponse.success,
        message: userResponse.message,
        data: userResponse.data,
      );
    } catch (e) {
      // Re-throws any caught exceptions for further handling
      rethrow;
    }
  }
}

/// A provider for the [ApiShowUserNotifier].
///
/// This provider creates an instance of [ApiShowUserNotifier] with
/// a [Dio] client configured to use a token interceptor for authorization.
final apiShowUserNotifierProvider =
    StateNotifierProvider<ApiShowUserNotifier, UserResponse>((ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  // dio.interceptors.add(TokenInterceptorInjector());
  dio.interceptors.addAll(List.of([
    TokenInterceptorInjector(),
    LogInterceptor(
      responseBody: true,
      error: true,
    )
  ]));
  return ApiShowUserNotifier(UserApiClient(dio));
});

final loadingShowUserProvider = StateProvider<bool>((state) => false);
