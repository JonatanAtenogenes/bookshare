import 'package:uuid/uuid.dart';

class ApiResponse {
  // Create a static instance of Uuid to reuse it
  static const Uuid _uuid = Uuid();

  final String id;
  final bool hasError;
  final String message;

  ApiResponse({
    required this.id,
    required this.hasError,
    required this.message,
  });

  // Constructor for a successful response
  factory ApiResponse.success() {
    return ApiResponse(
      id: _uuid.v4(), // Generate a unique UUID
      hasError: false,
      message: 'Success',
    );
  }

  // Constructor for an error response
  factory ApiResponse.error(String message) {
    return ApiResponse(
      id: _uuid.v4(), // Generate a unique UUID
      hasError: true,
      message: message,
    );
  }
}
