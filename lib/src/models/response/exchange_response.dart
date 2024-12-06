import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/data_response.dart';

/// Represents a response containing a single [Exchange] object.
///
/// This class encapsulates the API response for retrieving a single exchange,
/// providing details about the success of the operation, a message, and the
/// retrieved exchange data (if available).
class ExchangeResponse extends DataResponse<Exchange> {
  /// Creates an instance of [ExchangeResponse].
  ///
  /// - [success]: A boolean indicating whether the API call was successful.
  /// - [message]: A descriptive message about the API response.
  /// - [data]: The exchange object returned by the API (optional).
  ExchangeResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [ExchangeResponse] instance from a JSON object.
  ///
  /// This factory method parses the given JSON and extracts the response
  /// details, including the exchange data if available.
  ///
  /// - [json]: A Map representing the JSON response from the API.
  ///
  /// Returns a new [ExchangeResponse] instance.
  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? Exchange.fromJsonWithoutKey(json['data'])
          : null,
    );
  }

  /// Converts the [ExchangeResponse] to a JSON object.
  ///
  /// This method serializes the response into a Map format suitable
  /// for JSON encoding.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  /// Creates a successful [ExchangeResponse] with a predefined message.
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [ExchangeResponse] with an empty exchange instance.
  factory ExchangeResponse.success(String message) {
    return ExchangeResponse(
      success: true,
      message: message,
      data: Exchange.empty(),
    );
  }

  /// Creates an error [ExchangeResponse] with a predefined message.
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [ExchangeResponse] without any exchange data.
  factory ExchangeResponse.error(String message) {
    return ExchangeResponse(
      success: false,
      message: message,
      data: null,
    );
  }

  /// Creates a copy of this [ExchangeResponse] with updated values.
  ///
  /// - [success]: Optionally overrides the success value.
  /// - [message]: Optionally overrides the response message.
  /// - [data]: Optionally overrides the exchange data.
  ///
  /// Returns a new [ExchangeResponse] instance with the specified changes.
  ExchangeResponse copyWith({
    bool? success,
    String? message,
    Exchange? data,
  }) {
    return ExchangeResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

/// Represents a response containing a list of [Exchange] objects.
///
/// This class encapsulates the API response for retrieving multiple exchanges,
/// including details about the operation's success, a message, and the list of
/// exchanges (if available).
class ExchangeListResponse extends DataResponse<List<Exchange>> {
  /// Creates an instance of [ExchangeListResponse].
  ///
  /// - [success]: A boolean indicating whether the API call was successful.
  /// - [message]: A descriptive message about the API response.
  /// - [data]: A list of exchange objects returned by the API (optional).
  ExchangeListResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [ExchangeListResponse] instance from a JSON object.
  ///
  /// This factory method parses the given JSON and extracts the response
  /// details, including the list of exchanges if available.
  ///
  /// - [json]: A Map representing the JSON response from the API.
  ///
  /// Returns a new [ExchangeListResponse] instance.
  factory ExchangeListResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? Exchange.fromJsonListWithoutKey(json['data'])
          : null,
    );
  }

  /// Converts the [ExchangeListResponse] to a JSON object.
  ///
  /// This method serializes the response into a Map format suitable
  /// for JSON encoding.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((exchange) => exchange.toJson()).toList(),
    };
  }

  /// Creates a successful [ExchangeListResponse] with a predefined message.
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [ExchangeListResponse] with no exchange data.
  factory ExchangeListResponse.success(String message) {
    return ExchangeListResponse(
      success: true,
      message: message,
      data: [],
    );
  }

  /// Creates an error [ExchangeListResponse] with a predefined message.
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [ExchangeListResponse] without any exchange data.
  factory ExchangeListResponse.error(String message) {
    return ExchangeListResponse(
      success: false,
      message: message,
      data: null,
    );
  }

  /// Creates a copy of this [ExchangeListResponse] with updated values.
  ///
  /// - [success]: Optionally overrides the success value.
  /// - [message]: Optionally overrides the response message.
  /// - [data]: Optionally overrides the list of exchanges.
  ///
  /// Returns a new [ExchangeListResponse] instance with the specified changes.
  ExchangeListResponse copyWith({
    bool? success,
    String? message,
    List<Exchange>? data,
  }) {
    return ExchangeListResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
