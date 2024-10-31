import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth/auth_api_client.dart';
import '../../models/api/api_response.dart';

final loadingApiLogoutProvider = StateProvider<bool>((ref) => false);
final acceptedApiLogoutProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.error(""));

class ApiLogoutNotifier extends StateNotifier<void> {
  final AuthApiClient _authApiClient;

  ApiLogoutNotifier(this._authApiClient) : super(_authApiClient);

  Future<void> logoutUser() async {
    try {
      await _authApiClient.logoutUser();
    } catch (e) {
      log('Error login user: $e'); // Log the error
      rethrow;
    }
  }
}

final apiLogoutNotifierProvider =
    StateNotifierProvider<ApiLogoutNotifier, void>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    );

    // Add the built-in LogInterceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      // Log request details
      requestHeader: true,
      // Log request headers
      responseHeader: false,
      responseBody: true,
      // Log response headers (optional)
      error: true,
      // Log errors
      logPrint: (object) => log(object.toString()), // Use Dart's log function
    ));

    return ApiLogoutNotifier(AuthApiClient(dio));
  },
);
