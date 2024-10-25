import 'dart:developer';

import 'package:bookshare/src/data/auth_api_client.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiClient = Provider<AuthApiClient>((ref) {
  final dio = Dio();
  return AuthApiClient(dio);
});

final csrfTokenProvider =
    StateNotifierProvider<CsrfTokenNotifier, CsrfToken>((ref) {
  return CsrfTokenNotifier()..getCsrfToken();
});

class CsrfTokenNotifier extends StateNotifier<CsrfToken> {
  final _authApiClient = AuthApiClient(
    Dio(
      BaseOptions(contentType: 'application/json'),
    ),
  );

  CsrfTokenNotifier() : super(CsrfToken(csrfToken: ""));

  Future<CsrfToken> getCsrfToken() async {
    try {
      final csrfToken = await _authApiClient.getCsrfToken();
      state = csrfToken;
      return csrfToken;
    } catch (e) {
      log('Error getting csrf token: $e');
      rethrow; // Rethrow the exception to be handled elsewhere
    }
  }
}
