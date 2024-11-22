import '../models.dart';
import 'data_response.dart';
import '../address/address.dart';

class AddressResponse extends DataResponse<Address> {
  AddressResponse({
    required super.success,
    required super.message,
    super.data,
  });

  // Factory constructor to create AddressResponse from JSON
  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data:
          json['api'] != null ? Address.fromJsonWithoutKey(json['api']) : null,
    );
  }

  // Method to convert AddressResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.toJson(),
    };
  }

  // Factory constructor for a successful AddressResponse
  factory AddressResponse.success(String message) {
    return AddressResponse(
      success: true,
      message: message,
      data: Address
          .empty(), // Assuming you have a method to create an empty Address
    );
  }

  // Factory constructor for an error AddressResponse
  factory AddressResponse.error(String message) {
    return AddressResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
