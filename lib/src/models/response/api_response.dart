import 'package:uuid/uuid.dart';

/// A class representing a standardized API response.
///
/// This class provides a unique identifier for each response, indicates
/// whether the operation was successful, and includes a message describing the result.
class ApiResponse {
  /// Static instance of Uuid for generating unique IDs.
  static const Uuid _uuid = Uuid();

  /// Unique identifier for the response.
  final String id;

  /// Flag indicating if the response is successful.
  final bool success;

  /// Message providing additional information about the response.
  final String message;

  /// Creates an [ApiResponse] instance.
  ApiResponse({
    required this.id,
    required this.success,
    required this.message,
  });

  /// Factory constructor for a successful response.
  ///
  /// Generates a unique ID, sets [success] to true, and sets a default
  /// success message.
  factory ApiResponse.success() {
    return ApiResponse(
      id: _uuid.v4(), // Generate a unique UUID
      success: true,
      message: 'Success',
    );
  }

  /// Factory constructor for an error response.
  ///
  /// Generates a unique ID, sets [success] to false, and includes a custom
  /// error message.
  factory ApiResponse.error(String message) {
    return ApiResponse(
      id: _uuid.v4(), // Generate a unique UUID
      success: false,
      message: message,
    );
  }

  /// Converts an [ApiResponse] instance to a JSON-compatible map.
  ///
  /// Returns a map with keys `id`, `success`, and `message`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'success': success,
      'message': message,
    };
  }

  /// Creates an [ApiResponse] instance from a JSON map.
  ///
  /// The JSON map should contain `id`, `success`, and `message` keys.
  ///
  /// Throws a [FormatException] if any required key is missing.
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      id: _uuid.v4(),
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}
