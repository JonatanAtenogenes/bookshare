import 'dart:developer';

import '../models.dart';
import 'data_response.dart';

/// Represents a response containing a single Book object.
class BookResponse extends DataResponse<Book> {
  /// Constructor for [BookResponse].
  ///
  /// - [success]: Indicates whether the API call was successful.
  /// - [message]: The response message.
  /// - [data]: The book data, can be null.
  BookResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [BookResponse] instance from a JSON object.
  ///
  /// - [json]: The JSON object containing response data.
  ///
  /// Returns a new [BookResponse].
  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['api'] != null
          ? Book.fromJsonWithoutKey(json['api']['book'])
          : null,
    );
  }

  /// Converts the [BookResponse] to a JSON object.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.toJson(),
    };
  }

  /// Factory constructor for creating a successful [BookResponse].
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [BookResponse] with an empty book.
  factory BookResponse.success(String message) {
    return BookResponse(
      success: true,
      message: message,
      data: Book.empty(),
    );
  }

  /// Factory constructor for creating an error [BookResponse].
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [BookResponse] without data.
  factory BookResponse.error(String message) {
    return BookResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}

/// Represents a response containing a list of Book objects.
class BookListResponse extends DataResponse<List<Book>> {
  /// Constructor for [BookListResponse].
  ///
  /// - [success]: Indicates whether the API call was successful.
  /// - [message]: The response message.
  /// - [data]: The list of books, can be null.
  BookListResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [BookListResponse] instance from a JSON object.
  ///
  /// - [json]: The JSON object containing response data.
  ///
  /// Returns a new [BookListResponse].
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

  /// Converts the [BookListResponse] to a JSON object.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'api': data?.map((book) => book.toJson()).toList(),
    };
  }

  /// Factory constructor for creating a successful [BookListResponse].
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [BookListResponse] with no data.
  factory BookListResponse.success(String message) {
    return BookListResponse(
      success: true,
      message: message,
      data: null,
    );
  }

  /// Factory constructor for creating an error [BookListResponse].
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [BookListResponse] without data.
  factory BookListResponse.error(String message) {
    return BookListResponse(
      success: false,
      message: message,
      data: null,
    );
  }
}
