import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth/auth_api_client.dart';
import '../../models/api/api_response.dart';
import '../../models/models.dart';

final loadingApiLoginProvider = StateProvider<bool>((ref) => false);
final acceptedApiLoginProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.error(""));

class ApiLoginNotifier extends StateNotifier<User> {
  final AuthApiClient _authApiClient;

  ApiLoginNotifier(this._authApiClient) : super(User.empty());

  Future<User> loginUser(User user) async {
    try {
      final loggedUser = await _authApiClient.loginUser(user);
      state = loggedUser;
      return loggedUser;
    } catch (e) {
      log('Error login user: $e'); // Log the error
      rethrow;
    }
  }
}

final apiLoginNotifierProvider = StateNotifierProvider<ApiLoginNotifier, User>(
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

    return ApiLoginNotifier(AuthApiClient(dio));
  },
);
