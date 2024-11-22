import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enum/enums.dart';
import '../models/models.dart';
import '../models/response/api_response.dart';
import '../view_models/auth/api_login_provider.dart';
import '../view_models/user/user_provider.dart';

class AuthData {
  Future<void> loginUser(Ref ref, String email, String password) async {
    try {
      ref
          .read(acceptedApiLoginProvider.notifier)
          .update((state) => ApiResponse.success());

      final user = User(
        id: "",
        email: email,
        password: password,
        role: Roles.user.name,
      );

      await ref.read(apiLoginNotifierProvider.notifier).loginUser(user);
      ref
          .read(currentUserProvider.notifier)
          .update((state) => ref.read(apiLoginNotifierProvider));

      log("current user: ${ref.read(currentUserProvider)}");

      // return true; // Login successful
    } on DioException catch (e) {
      String message = "An unexpected error has occurred";
      ref.read(acceptedApiLoginProvider.notifier).update(
            (state) =>
                ApiResponse.error(e.response?.data['message'] ?? message),
          );
      log("status: ${ref.read(acceptedApiLoginProvider).success}");
      // return false; // Login failed
    } finally {
      ref
          .read(loadingApiLoginProvider.notifier)
          .update((state) => state = false);
    }
  }
}
