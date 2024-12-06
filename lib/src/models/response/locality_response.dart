import 'dart:developer';

import '../address/locality.dart';

/// A response class for retrieving locality information, including
/// the status, message, and a list of [Locality] objects.
class LocalityResponse {
  /// Status of the response, indicating success or failure.
  final bool success;

  /// Message accompanying the response.
  final String message;

  /// List of localities returned in the response.
  final List<Locality> localities;

  /// Creates an instance of [LocalityResponse].
  LocalityResponse({
    required this.success,
    required this.message,
    required this.localities,
  });

  /// Creates an empty instance of [LocalityResponse].
  ///
  /// This constructor initializes the response with default values:
  /// - `status` as `false`
  /// - `message` as an empty string
  /// - `localities` as an empty list
  LocalityResponse.empty()
      : success = false,
        message = '',
        localities = [];

  /// Creates a [LocalityResponse] instance from a JSON map.
  ///
  /// The JSON map should contain the keys `status`, `message`, and `localities`.
  /// The `localities` key should map to a list of locality JSON objects.
  factory LocalityResponse.fromJson(Map<String, dynamic> json) {
    log('Localities in json $json}');
    final localitiesJson = json['data'] as List<dynamic>;
    return LocalityResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      localities: Locality.fromJsonList(localitiesJson),
    );
  }
}
