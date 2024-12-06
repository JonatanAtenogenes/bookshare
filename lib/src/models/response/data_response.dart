/// A generic class that represents a response from the server.
///
/// This class contains a success flag, a message, and optional api of type [T].
///
/// [T] is the type of api expected in the response.
///
/// Example:
/// ```dart
/// final response = DataResponse<User>(
///   success: true,
///   message: "User retrieved successfully",
///   api: userInstance,
/// );
/// ```
class DataResponse<T> {
  /// Indicates whether the request was successful.
  final bool success;

  /// A message providing additional information about the response.
  final String message;

  /// The api returned in the response, which may be null.
  final T? data;

  /// Creates an instance of [DataResponse].
  ///
  /// [success] must not be null.
  /// [message] must not be null.
  /// [api] is optional and may be null.
  DataResponse({
    required this.success,
    required this.message,
    this.data,
  });
}
