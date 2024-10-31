//
import 'dart:developer';

import 'package:bookshare/src/data/auth/auth_api_client.dart';
import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingApiRegisterProvider = StateProvider<bool>((ref) => false);
final acceptedApiRegisterProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.success());

final apiRegisterNotifierProvider =
    StateNotifierProvider<ApiRegisterNotifier, User>(
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

    return ApiRegisterNotifier(AuthApiClient(dio));
  },
);

class ApiRegisterNotifier extends StateNotifier<User> {
  final AuthApiClient _authApiClient;

  ApiRegisterNotifier(this._authApiClient) : super(User.empty());

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
