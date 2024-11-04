import 'dart:io';

import 'package:bookshare/src/data/api.dart';
import 'package:bookshare/src/models/api/api_response.dart';
import 'package:bookshare/src/models/api/file_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/user/user.dart';

part 'user_api_client.g.dart';

/// A Retrofit API client for handling user-related HTTP requests.
///
/// This client includes methods for updating personal information
/// and uploading profile images, communicating with the backend.
@RestApi(baseUrl: Api.baseUrl)
abstract class UserApiClient {
  /// Factory constructor for creating an instance of [UserApiClient].
  /// - [dio]: The Dio instance for making network requests.
  /// - [baseUrl]: Optional custom base URL for overriding the default.
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  /// Updates the personal information for a specific user.
  ///
  /// Makes a PUT request to update the user's personal information with new data.
  /// - [id]: The unique identifier of the user to update.
  /// - [user]: An instance of the [User] model containing the updated user data.
  @PUT(Api.updatePersonalInformation)
  Future<ApiResponse> updatePersonalInformation(
    @Path('id') String id,
    @Body() User user,
  );

  /// Uploads a profile image for a specific user.
  ///
  /// Makes a POST request to upload an image file, which is sent as a multipart form.
  /// - [file]: The image file to be uploaded.
  /// - [userId]: The unique identifier of the user uploading the image.
  ///
  /// Returns a [FileResponse] containing the status, message, and path of the uploaded file.
  @POST(Api.uploadProfileImage)
  @MultiPart()
  Future<FileResponse> uploadProfileImage(
    @Part(name: 'file') File file,
    @Part(name: 'userId') String userId,
  );

  /// Sends a PUT request to update the address information of a user.
  ///
  /// This method updates the address information of a specific user by their ID.
  /// It sends a JSON payload containing user details to the server.
  ///
  /// - **Parameters**:
  ///   - `id`: The unique identifier of the user.
  ///   - `user`: The `User` object containing updated address information.
  ///
  /// - **Returns**: A `Future` that resolves to an `ApiResponse` indicating
  ///   the success or failure of the update operation.
  @PUT(Api.updateAddressInformation)
  Future<ApiResponse> updateAddressInformation(
    @Path('id') String id,
    @Body() User user,
  );
}
