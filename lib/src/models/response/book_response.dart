import 'dart:developer';

import '../models.dart';
import 'data_response.dart';

class BookResponse extends DataResponse<Book> {
  BookResponse({
    required super.success,
    required super.message,
    super.data,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['api'] != null
          ? Book.fromJsonWithoutKey(json['api']['book'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.toJson(),
    };
  }

  factory BookResponse.success(String message) {
    return BookResponse(
      success: true,
      message: message,
      data: Book.empty(),
    );
  }

  factory BookResponse.error(String message) {
    return BookResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}

class BookListResponse extends DataResponse<List<Book>> {
  BookListResponse({
    required super.success,
    required super.message,
    super.data,
  });

  factory BookListResponse.fromJson(Map<String, dynamic> json) {
    log('---------------------');
    log('Booklist Response');
    log(json.toString());
    return BookListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data:
          json['api'] != null ? Book.fromJsonListWithoutKey(json['api']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.map((book) => book.toJson()).toList(),
    };
  }

  factory BookListResponse.success(String message) {
    return BookListResponse(
      success: true,
      message: message,
      data: null,
    );
  }

  factory BookListResponse.error(String message) {
    return BookListResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
