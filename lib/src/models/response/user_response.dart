import '../models.dart';
import 'data_response.dart';

/// A class representing the response for user-related operations.
///
/// This class extends [DataResponse<User>] and includes functionality
/// for converting between JSON representations and [UserResponse] objects.
///
/// Example usage:
/// ```dart
/// final userResponse = UserResponse.fromJson(jsonResponse);
/// ```
class UserResponse extends DataResponse<User> {
  /// Creates an instance of [UserResponse].
  ///
  /// - [success] indicates whether the operation was successful. Must not be null.
  /// - [message] provides additional details about the response. Must not be null.
  /// - [data] contains the [User] object or null if not available.
  UserResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [UserResponse] instance from a JSON map.
  ///
  /// - [json] is a `Map<String, dynamic>` representing the JSON response.
  ///
  /// Returns a [UserResponse] object with values extracted from the JSON.
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? User.fromJsonWithoutKey(json['data']) : null,
    );
  }

  /// Creates a copy of the current [UserResponse] instance with optional overrides.
  ///
  /// This is useful for creating a modified version of an existing response while
  /// keeping other fields unchanged.
  ///
  /// Example:
  /// ```dart
  /// final updatedResponse = userResponse.copyWith(message: 'Updated message');
  /// ```
  ///
  /// - [success]: Overrides the current success status if provided.
  /// - [message]: Overrides the current message if provided.
  /// - [data]: Overrides the current [User] object if provided.
  ///
  /// Returns a new [UserResponse] instance with the updated values.
  UserResponse copyWith({
    bool? success,
    String? message,
    User? data,
  }) {
    return UserResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  /// Converts the [UserResponse] instance to a JSON map.
  ///
  /// Returns a `Map<String, dynamic>` representation of the [UserResponse].
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  /// Creates a successful [UserResponse] instance.
  ///
  /// This factory constructor initializes the response with:
  /// - [success] set to `true`.
  /// - [message] set to the provided success message.
  /// - [data] initialized as a default [User.empty()] instance.
  ///
  /// Useful for generating default success responses without user data.
  factory UserResponse.success(String message) {
    return UserResponse(
      success: true,
      message: message,
      data: User.empty(),
    );
  }

  /// Creates an error [UserResponse] instance.
  ///
  /// This factory constructor initializes the response with:
  /// - [success] set to `false`.
  /// - [message] set to the provided error message.
  /// - [data] set to `null`.
  ///
  /// Useful for generating default error responses from API calls.
  factory UserResponse.error(String message) {
    return UserResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
