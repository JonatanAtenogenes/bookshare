import 'dart:developer';
import 'dart:io';

import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/data/user/user_api_client.dart';
import 'package:bookshare/src/models/api/file_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A StateNotifier responsible for managing the state of image upload requests.
class ApiUploadImageNotifier extends StateNotifier<FileResponse> {
  // API client for user-related network requests.
  final UserApiClient _userApiClient;

  /// Constructor initializes the notifier with an empty [FileResponse] state.
  /// - [_userApiClient] is the API client that handles requests for user data.
  ApiUploadImageNotifier(this._userApiClient) : super(FileResponse.empty());

  /// Uploads a profile image for a specific user.
  /// - [file]: The image file to upload.
  /// - [userId]: The unique identifier of the user.
  ///
  /// Updates the state with the response returned by the upload API.
  /// In case of an error, it rethrows the exception for further handling.
  Future<void> uploadProfileImage(File file, String userId) async {
    try {
      final fileData = await _userApiClient.uploadProfileImage(file, userId);
      log(fileData.message);
      state = fileData;
    } catch (e) {
      // Rethrow the caught exception to be handled by the caller if needed.
      rethrow;
    }
  }
}

/// Provider to manage the instance of [ApiUploadImageNotifier].
final apiUploadImageNotifierProvider =
    StateNotifierProvider<ApiUploadImageNotifier, FileResponse>(
  (ref) {
    // Initializes Dio with default options and injects the token interceptor.
    final dio = Dio(
      BaseOptions(contentType: Headers.multipartFormDataContentType),
    );
    dio.interceptors.add(TokenInterceptorInjector());

    // Returns an instance of [ApiUploadImageNotifier] with a [UserApiClient] dependency.
    return ApiUploadImageNotifier(UserApiClient(dio));
  },
);
