import 'dart:developer';

import '../models.dart';
import 'data_response.dart';

/// Represents a response containing a single [Book] object.
///
/// This class is used to encapsulate the API response for retrieving
/// a single book, providing details about the success of the operation,
/// a message, and the retrieved book data (if available).
class BookResponse extends DataResponse<Book> {
  /// Creates an instance of [BookResponse].
  ///
  /// - [success]: A boolean indicating whether the API call was successful.
  /// - [message]: A descriptive message about the API response.
  /// - [data]: The book object returned by the API (optional).
  BookResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [BookResponse] instance from a JSON object.
  ///
  /// This factory method parses the given JSON and extracts the response
  /// details, including the book data if available.
  ///
  /// - [json]: A Map representing the JSON response from the API.
  ///
  /// Returns a new [BookResponse] instance.
  factory BookResponse.fromJson(Map<String, dynamic> json) {
    log("Book response form json $json");
    return BookResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? Book.fromJsonWithoutKey(json['data']) : null,
    );
  }

  /// Converts the [BookResponse] to a JSON object.
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

  /// Creates a successful [BookResponse] with a predefined message.
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [BookResponse] with an empty book instance.
  factory BookResponse.success(String message) {
    return BookResponse(
      success: true,
      message: message,
      data: Book.empty(),
    );
  }

  /// Creates an error [BookResponse] with a predefined message.
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [BookResponse] without any book data.
  factory BookResponse.error(String message) {
    return BookResponse(
      success: false,
      message: message,
      data: null,
    );
  }

  /// Creates a copy of this [BookResponse] with updated values.
  ///
  /// - [success]: Optionally overrides the success value.
  /// - [message]: Optionally overrides the response message.
  /// - [data]: Optionally overrides the book data.
  ///
  /// Returns a new [BookResponse] instance with the specified changes.
  BookResponse copyWith({
    bool? success,
    String? message,
    Book? data,
  }) {
    return BookResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

/// Represents a response containing a list of [Book] objects.
///
/// This class is used to encapsulate the API response for retrieving
/// multiple books, including details about the operation's success,
/// a message, and the list of books (if available).
class BookListResponse extends DataResponse<List<Book>> {
  /// Creates an instance of [BookListResponse].
  ///
  /// - [success]: A boolean indicating whether the API call was successful.
  /// - [message]: A descriptive message about the API response.
  /// - [data]: A list of book objects returned by the API (optional).
  BookListResponse({
    required super.success,
    required super.message,
    super.data,
  });

  /// Creates a [BookListResponse] instance from a JSON object.
  ///
  /// This factory method parses the given JSON and extracts the response
  /// details, including the list of books if available.
  ///
  /// - [json]: A Map representing the JSON response from the API.
  ///
  /// Returns a new [BookListResponse] instance.
  factory BookListResponse.fromJson(Map<String, dynamic> json) {
    log('---------------------');
    log('BookList Response');
    log(json.toString());
    return BookListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? Book.fromJsonListWithoutKey(json['data'])
          : null,
    );
  }

  /// Converts the [BookListResponse] to a JSON object.
  ///
  /// This method serializes the response into a Map format suitable
  /// for JSON encoding.
  ///
  /// Returns a Map representation of the response.
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((book) => book.toJson()).toList(),
    };
  }

  /// Creates a successful [BookListResponse] with a predefined message.
  ///
  /// - [message]: The success message.
  ///
  /// Returns a [BookListResponse] with no book data.
  factory BookListResponse.success(String message) {
    return BookListResponse(
      success: true,
      message: message,
      data: null,
    );
  }

  /// Creates an error [BookListResponse] with a predefined message.
  ///
  /// - [message]: The error message.
  ///
  /// Returns a [BookListResponse] without any book data.
  factory BookListResponse.error(String message) {
    return BookListResponse(
      success: false,
      message: message,
      data: null,
    );
  }

  /// Creates a copy of this [BookListResponse] with updated values.
  ///
  /// - [success]: Optionally overrides the success value.
  /// - [message]: Optionally overrides the response message.
  /// - [data]: Optionally overrides the list of books.
  ///
  /// Returns a new [BookListResponse] instance with the specified changes.
  BookListResponse copyWith({
    bool? success,
    String? message,
    List<Book>? data,
  }) {
    return BookListResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
