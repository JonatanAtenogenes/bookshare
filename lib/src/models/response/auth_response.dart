import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/models/response/data_response.dart';

/// Represents a response containing a User object for authentication-related actions.
class AuthResponse extends DataResponse<User> {
  /// Constructor for [AuthResponse].
  ///
  /// - [success]: Indicates whether the API call was successful.
  /// - [message]: The response message.
  /// - [data]: The user data, can be null.
  AuthResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a copy of this [AuthResponse] with the given fields replaced by new values.
  ///
  /// - [success]: Overrides the current success value.
  /// - [message]: Overrides the current message value.
  /// - [data]: Overrides the current data value.
  ///
  /// Returns a new [AuthResponse] instance with the specified fields updated.
  AuthResponse copyWith({
    bool? success,
    String? message,
    User? data,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  /// Creates an [AuthResponse] instance from a JSON object.
  ///
  /// - [json]: The JSON object containing response data.
  ///
  /// Returns a new [AuthResponse].
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? User.fromJsonWithoutKey(json['data']['user'])
          : null,
    );
  }

  /// Converts the [AuthResponse] to a JSON object.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  /// Factory constructor for creating a successful [AuthResponse].
  ///
  /// - [message]: The success message.
  ///
  /// Returns an [AuthResponse] with an empty user.
  factory AuthResponse.success(String message) {
    return AuthResponse(
      success: true,
      message: message,
      data: User.empty(),
    );
  }

  /// Factory constructor for creating an error [AuthResponse].
  ///
  /// - [message]: The error message.
  ///
  /// Returns an [AuthResponse] without data.
  factory AuthResponse.error(String message) {
    return AuthResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
