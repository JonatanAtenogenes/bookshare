//
import 'dart:developer';

import 'package:bookshare/src/data/auth/auth_api_client.dart';
import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingRegisterProvider = StateProvider<bool>((ref) => false);
final errorRegisterProvider =
    StateProvider<ApiResponse>((ref) => ApiResponse.success());

final registerNotifierProvider = StateNotifierProvider<RegisterNotifier, User>(
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

    return RegisterNotifier(AuthApiClient(dio));
  },
);

class RegisterNotifier extends StateNotifier<User> {
  final AuthApiClient _authApiClient;

  RegisterNotifier(this._authApiClient) : super(User.empty());

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
