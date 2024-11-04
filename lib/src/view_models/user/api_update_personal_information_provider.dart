import 'dart:developer';

import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/data/user/user_api_client.dart';
import 'package:bookshare/src/models/api/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user/user.dart';

/// A notifier for managing the update of user personal information.
///
/// This class extends [StateNotifier] and is responsible for updating
/// user details by communicating with the [UserApiClient]. It holds
/// the current state of the user and updates it when new information
/// is successfully received from the API.
class ApiUpdatePersonalInformationNotifier extends StateNotifier<ApiResponse> {
  final UserApiClient _userApiClient;

  /// Creates an instance of [ApiUpdatePersonalInformationNotifier].
  ///
  /// - [userApiClient]: The [UserApiClient] instance used for API requests.
  ApiUpdatePersonalInformationNotifier(this._userApiClient)
      : super(ApiResponse.success());

  /// Updates the personal information of a user.
  ///
  /// Sends the provided [user] data to the API to update the user's
  /// personal information. If the request is successful, the state
  /// is updated with the new user data.
  ///
  /// - [user]: The user object containing the updated personal information.
  Future<void> updatePersonalInformation(User user) async {
    try {
      final updatedUserState =
          await _userApiClient.updatePersonalInformation(user.id, user);
      log("Updated state in provider: ${updatedUserState.success}");
      state = updatedUserState; // Update the state with the new user data.
    } catch (e) {
      log("Error must be retrowed");
      rethrow; // Rethrow the error for handling by the caller.
    }
  }
}

/// A provider for [ApiUpdatePersonalInformationNotifier].
///
/// This provider creates an instance of the notifier and manages its lifecycle,
/// injecting the required [UserApiClient] with a Dio instance configured
/// with interceptors.
final apiUpdatePersonalInfoNotifierProvider =
    StateNotifierProvider<ApiUpdatePersonalInformationNotifier, ApiResponse>(
  (ref) {
    final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dio.interceptors.add(
      TokenInterceptorInjector(),
    ); // Add token interceptor for authentication.

    return ApiUpdatePersonalInformationNotifier(UserApiClient(dio));
  },
);
