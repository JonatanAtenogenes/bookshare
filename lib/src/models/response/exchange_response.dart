import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/data_response.dart';

class ExchangeResponse extends DataResponse<Exchange> {
  ExchangeResponse({
    required super.success,
    required super.message,
    super.data,
  });

  // Factory constructor to create ExchangeResponse from JSON
  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['api'] != null
          ? Exchange.fromJson(json['api'])
          : null, // Assuming Exchange has a fromJson method
    );
  }

  // Method to convert ExchangeResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.toJson(), // Assuming Exchange has a toJson method
    };
  }

  // Factory constructor for a successful ExchangeResponse
  factory ExchangeResponse.success(String message) {
    return ExchangeResponse(
      success: true,
      message: message,
      data: Exchange.empty(), // Assuming Exchange has an empty method
    );
  }

  // Factory constructor for an error ExchangeResponse
  factory ExchangeResponse.error(String message) {
    return ExchangeResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
