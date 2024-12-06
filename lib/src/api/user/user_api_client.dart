import 'dart:io';

import 'package:bookshare/src/api/api.dart';
import 'package:bookshare/src/models/response/api_response.dart';
import 'package:bookshare/src/models/response/file_response.dart';
import 'package:bookshare/src/models/response/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/address/address.dart';
import '../../models/user/user.dart';

part 'user_api_client.g.dart';

/// A Retrofit API client for handling user-related HTTP requests.
///
/// This client includes methods for retrieving user information, updating
/// user data, uploading profile images, and managing address details. It
/// communicates with the backend using HTTP requests defined in the [Api] endpoints.
@RestApi(baseUrl: Api.baseUrl)
abstract class UserApiClient {
  /// Factory constructor for creating an instance of [UserApiClient].
  ///
  /// - [dio]: The Dio instance for making network requests.
  /// - [baseUrl]: Optional custom base URL for overriding the default value in [Api.baseUrl].
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  /// Retrieves the details of a specific user by their ID.
  ///
  /// Makes a GET request to fetch user information from the server.
  ///
  /// - **Parameters**:
  ///   - [id]: The unique identifier of the user.
  ///
  /// - **Returns**: A [Future] that resolves to a [UserResponse] containing user details.
  ///
  /// Example:
  /// ```dart
  /// final userResponse = await userApiClient.showUser('user_id');
  /// ```
  @GET(Api.showUser)
  Future<UserResponse> showUser(@Path('id') String id);

  /// Updates the personal information of a specific user.
  ///
  /// Makes a PUT request to update the user's personal information on the server.
  ///
  /// - **Parameters**:
  ///   - [id]: The unique identifier of the user to update.
  ///   - [user]: An instance of the [User] model containing the updated data.
  ///
  /// - **Returns**: A [Future] that resolves to an [ApiResponse] indicating
  ///   whether the operation was successful.
  ///
  /// Example:
  /// ```dart
  /// final response = await userApiClient.updatePersonalInformation(
  ///   'user_id',
  ///   updatedUser,
  /// );
  /// ```
  @PUT(Api.updatePersonalInformation)
  Future<ApiResponse> updatePersonalInformation(
    @Path('id') String id,
    @Body() User user,
  );

  /// Uploads a profile image for a specific user.
  ///
  /// Makes a POST request to upload an image file as a multipart form data request.
  ///
  /// - **Parameters**:
  ///   - [file]: The image file to be uploaded.
  ///   - [userId]: The unique identifier of the user uploading the image.
  ///
  /// - **Returns**: A [Future] that resolves to a [FileResponse], which includes
  ///   details about the uploaded file (e.g., status, message, and file path).
  ///
  /// Example:
  /// ```dart
  /// final fileResponse = await userApiClient.uploadProfileImage(
  ///   File('path/to/image.jpg'),
  ///   'user_id',
  /// );
  /// ```
  @POST(Api.uploadProfileImage)
  @MultiPart()
  Future<FileResponse> uploadProfileImage(
    @Part(name: 'file') File file,
    @Part(name: 'userId') String userId,
  );

  /// Updates the address information of a specific user.
  ///
  /// Makes a PUT request to send the updated address details of a user to the server.
  ///
  /// - **Parameters**:
  ///   - [id]: The unique identifier of the user whose address is being updated.
  ///   - [address]: An instance of the [Address] model containing the updated address details.
  ///
  /// - **Returns**: A [Future] that resolves to an [ApiResponse] indicating the
  ///   success or failure of the update operation.
  ///
  /// Example:
  /// ```dart
  /// final response = await userApiClient.updateAddressInformation(
  ///   'user_id',
  ///   updatedAddress,
  /// );
  /// ```
  @PUT(Api.updateAddressInformation)
  Future<ApiResponse> updateAddressInformation(
    @Path('id') String id,
    @Body() Address address,
  );
}
