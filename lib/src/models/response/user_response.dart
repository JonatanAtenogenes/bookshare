import '../models.dart';
import 'data_response.dart';

/// A class representing the response for user-related operations.
///
/// Inherits from [DataResponse<User>] and includes methods for converting
/// between JSON and the [UserResponse] object.
///
/// Example:
/// ```dart
/// final userResponse = UserResponse.fromJson(jsonResponse);
/// ```
class UserResponse extends DataResponse<User> {
  /// Creates an instance of [UserResponse].
  ///
  /// [success] must not be null.
  /// [message] must not be null.
  /// [api] is optional and may be null.
  UserResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [UserResponse] instance from a JSON map.
  ///
  /// [json] is a map representation of the user response received from the server.
  /// Returns a [UserResponse] object populated with api from the JSON.
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['api'] != null ? User.fromJsonWithoutKey(json['api']) : null,
    );
  }

  /// Creates a copy of the current [UserResponse] instance with the option to override specific fields.
  ///
  /// This method is useful for creating a modified copy of the existing object while
  /// keeping other fields unchanged.
  ///
  /// Example:
  /// ```dart
  /// final updatedResponse = userResponse.copyWith(message: 'Updated message');
  /// ```
  ///
  /// Parameters:
  /// - [success]: Overrides the current success status if provided.
  /// - [message]: Overrides the current message if provided.
  /// - [api]: Overrides the current api if provided.
  ///
  /// Returns:
  /// A new instance of [UserResponse] with updated fields.
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
  /// Returns a map representation of the user response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.toJson(),
    };
  }

  /// Creates a successful instance of [UserResponse].
  ///
  /// This factory constructor initializes a [UserResponse] object
  /// with default values for a successful response:
  /// - [success] is set to true.
  /// - [message] is set to a success message.
  /// - [api] is initialized with a [User.empty()] instance.
  ///
  /// This can be useful when you want to return a successful response
  /// without any actual user api.
  factory UserResponse.success(String message) {
    return UserResponse(
      success: true,
      message: message,
      data: User.empty(),
    );
  }

  /// Creates an error instance of [UserResponse].
  ///
  /// This factory constructor initializes a [UserResponse] object
  /// with default values for an error response:
  /// - [success] is set to false.
  /// - [message] is set to the provided error message.
  /// - [api] is set to null.
  ///
  /// This can be useful when returning an error response from an API call.
  factory UserResponse.error(String message) {
    return UserResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
