import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/data/user/user_api_client.dart';
import 'package:bookshare/src/models/api/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';

/// A state notifier for managing address update requests.
///
/// This notifier sends a request to update a user's address information and
/// manages the resulting `ApiResponse` state, reflecting the success or failure
/// of the update operation.
class ApiUpdateAddressInformationNotifier extends StateNotifier<ApiResponse> {
  final UserApiClient _userApiClient;

  /// Constructs the notifier with the given [UserApiClient].
  ApiUpdateAddressInformationNotifier(this._userApiClient)
      : super(ApiResponse.success());

  /// Updates the user's address information.
  ///
  /// This method attempts to update the address information of the specified
  /// user by calling the [updateAddressInformation] method of the API client.
  /// If the update is successful, it updates the state with the result.
  ///
  /// - **Parameters**:
  ///   - `user`: The `User` object containing updated address information.
  ///
  /// - **Throws**: Re-throws any exception encountered during the API call.
  Future<void> updateAddressInformation(User user) async {
    try {
      final updatedAddressState =
          await _userApiClient.updateAddressInformation(user.id, user);
      state = updatedAddressState;
    } catch (e) {
      // Preserve the error details and re-throw it for handling upstream.
      rethrow;
    }
  }
}

/// A provider for managing the state of the address update operation.
///
/// This provider creates an instance of [ApiUpdateAddressInformationNotifier],
/// which is responsible for updating the user's address information. It uses
/// [Dio] for making HTTP requests and applies the [TokenInterceptorInjector]
/// to handle authorization tokens automatically.
///
/// - **Returns**: A [StateNotifierProvider] that exposes the current state of
///   the address update operation as an [ApiResponse].
final apiUpdateAddressInfoNotifierProvider =
    StateNotifierProvider<ApiUpdateAddressInformationNotifier, ApiResponse>(
        (ref) {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  dio.interceptors.add(TokenInterceptorInjector());
  return ApiUpdateAddressInformationNotifier(UserApiClient(dio));
});
