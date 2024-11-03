import 'package:bookshare/src/utils/assets_access.dart';

/// Represents a response that includes a file path, status, and message.
class FileResponse {
  // Indicates whether the file operation was successful
  final bool status;

  // A message related to the file operation, often used for errors or success notes
  final String message;

  // The path to the file returned in the response
  final String filePath;

  /// Constructor to initialize the [FileResponse] instance with provided values.
  FileResponse({
    required this.status,
    required this.message,
    required this.filePath,
  });

  /// Factory constructor that creates a [FileResponse] object from JSON.
  /// It expects a JSON structure where:
  /// - `data` contains file information,
  /// - `success` is a boolean indicating the operation success,
  /// - `message` provides feedback related to the file operation.
  factory FileResponse.fromJson(Map<String, dynamic> json) {
    final fileData = json['data'];
    final status = json['success'] as bool;
    final message = json['message'];
    final filePath = fileData['filePath'];

    return FileResponse(status: status, message: message, filePath: filePath);
  }

  /// Factory constructor for creating an empty [FileResponse] with default values.
  /// Defaults:
  /// - `status` is set to `false`.
  /// - `message` is an empty string.
  /// - `filePath` is set to a default user image path.
  factory FileResponse.empty() {
    return FileResponse(
      status: false,
      message: "",
      filePath: AssetsAccess.defaultUserImage,
    );
  }
}
