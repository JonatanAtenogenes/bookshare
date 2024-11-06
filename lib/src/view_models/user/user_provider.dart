import 'package:bookshare/src/models/response/api_response.dart';
import 'package:bookshare/src/models/response/file_response.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that holds the current user information.
///
/// This provider uses [StateProvider] to manage the state of the current user.
/// It initializes with an empty user instance.
///
/// - Returns a [User] object, which represents the current user.
final currentUserProvider = StateProvider<User>((ref) => User.empty());

/// A provider that manages the state of uploaded image response data.
///
/// This provider uses [StateProvider] to hold the response data from the image upload process.
/// It initializes with an empty `FileResponse` instance.
///
/// - Returns a [FileResponse] object, which contains information about the uploaded image.
final uploadedImageDataProvider = StateProvider<FileResponse>(
  (ref) => FileResponse.empty(),
);

/// A provider that manages the state of the updated personal information response.
///
/// This provider uses [StateProvider] to hold the response data from updates
/// to personal information. It initializes with a successful `ApiResponse`
/// indicating that the update has succeeded.
///
/// - Returns an [ApiResponse] object, which encapsulates the result of the
///   personal information update operation.
final updatedPersonalInfoProvider = StateProvider<ApiResponse>(
  (ref) => ApiResponse.success(),
);

final updatedAddressInfoProvider = StateProvider<ApiResponse>(
  (ref) => ApiResponse.success(),
);

final localitiesInfoRetrievedProvider = StateProvider<ApiResponse>(
  (ref) => ApiResponse.success(),
);
