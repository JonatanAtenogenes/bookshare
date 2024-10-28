import 'package:bookshare/src/data/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiClient = Provider<AuthApiClient>((ref) {
  final dio = Dio();
  return AuthApiClient(dio);
});
