import 'dart:developer';

import '../enum/book_attributes.dart';
import '../enum/enums.dart';
import '../user/user.dart';

/// Represents a book with various attributes and methods to manage its api.
class Book {
  /// Unique identifier for the book.
  final String id;

  /// International Standard Book Number (ISBN) of the book.
  final String isbn;

  /// Title of the book.
  final String title;

  /// List of authors of the book.
  final List<String> authors;

  /// Synopsis or summary of the book.
  final String synopsis;

  /// URL or path to the book's image.
  final String image;

  /// Publisher of the book.
  final String publisher;

  /// User ID of the person who owns or is associated with the book.
  final String userId;

  /// Condition of the book, which may change over time.
  final int condition;

  /// Value of the book, which may increment or decrement.
  final int value;

  /// Status indicating whether the book is available or not (default is true).
  final bool status = true;

  /// Associated user for the book, if available.
  final User? user;

  /// Constructor for the `Book` class.
  Book({
    required this.id,
    required this.isbn,
    required this.title,
    required this.authors,
    required this.synopsis,
    required this.image,
    required this.publisher,
    required this.userId,
    required this.condition,
    required this.value,
    this.user,
  });

  /// Creates a copy of the current `Book` instance with updated fields.
  Book copyWith({
    String? id,
    String? isbn,
    String? title,
    List<String>? authors,
    String? synopsis,
    String? image,
    String? publisher,
    String? userId,
    int? condition,
    int? value,
    User? user,
  }) {
    return Book(
      id: id ?? this.id,
      isbn: isbn ?? this.isbn,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      synopsis: synopsis ?? this.synopsis,
      image: image ?? this.image,
      publisher: publisher ?? this.publisher,
      userId: userId ?? this.userId,
      condition: condition ?? this.condition,
      value: value ?? this.value,
      user: user ?? this.user,
    );
  }

  /// Factory method to create a `Book` instance from a JSON map.
  factory Book.fromJson(Map<String, dynamic> json) {
    log('json: $json');

    final bookData = json['book'];
    final id = bookData[BookAttributes.id.name] ?? BookAttributes.id.name;
    final isbn = bookData[BookAttributes.isbn.name] ?? BookAttributes.isbn.name;
    final title =
        bookData[BookAttributes.title.name] ?? BookAttributes.title.name;
    final authors =
        List<String>.from(bookData[BookAttributes.authors.name] ?? []);
    final synopsis =
        bookData[BookAttributes.synopsis.name] ?? BookAttributes.synopsis.name;
    final image = bookData[BookAttributes.image.name] ?? '';
    final publisher = bookData[BookAttributes.publisher.name] ?? '';
    final userId =
        bookData[BookAttributes.userId.name] ?? BookAttributes.userId.name;
    final condition = bookData[BookAttributes.condition.name] ?? 0;
    final value = bookData[BookAttributes.value.name] ?? 0;
    final user = bookData['user'] != null
        ? User.fromJson(bookData['user'])
        : User.empty();

    return Book(
      id: id,
      isbn: isbn,
      title: title,
      authors: authors,
      synopsis: synopsis,
      image: image,
      publisher: publisher,
      userId: userId,
      condition: condition,
      value: value,
      user: user,
    );
  }

  /// Factory method to create a `Book` instance from a JSON map without using a key.
  factory Book.fromJsonWithoutKey(Map<String, dynamic> json) {
    final id = json[BookAttributes.id.name] ?? BookAttributes.id.name;
    final isbn = json[BookAttributes.isbn.name] ?? BookAttributes.isbn.name;
    final title = json[BookAttributes.title.name] ?? BookAttributes.title.name;
    final authors = List<String>.from(json[BookAttributes.authors.name] ?? []);
    final synopsis =
        json[BookAttributes.synopsis.name] ?? BookAttributes.synopsis.name;
    final image = json[BookAttributes.image.name] ?? '';
    final publisher = json[BookAttributes.publisher.name] ?? '';
    final userId =
        json[BookAttributes.userId.name] ?? BookAttributes.userId.name;
    final condition = json[BookAttributes.condition.name] ?? 0;
    final value = json[BookAttributes.value.name] ?? 0;
    final user =
        json['user'] != null ? User.fromJson(json['user']) : User.empty();

    return Book(
      id: id,
      isbn: isbn,
      title: title,
      authors: authors,
      synopsis: synopsis,
      image: image,
      publisher: publisher,
      userId: userId,
      condition: condition,
      value: value,
      user: user,
    );
  }

  /// Getter for the book attributes as a map.
  Map<String, dynamic> get book {
    return {
      BookAttributes.id.name: id,
      BookAttributes.isbn.name: isbn,
      BookAttributes.title.name: title,
      BookAttributes.authors.name: authors,
      BookAttributes.synopsis.name: synopsis,
      BookAttributes.image.name: image,
      BookAttributes.publisher.name: publisher,
      BookAttributes.userId.name: userId,
      BookAttributes.condition.name: condition,
      BookAttributes.value.name: value,
      BookAttributes.status.name: status,
      'user': user?.toJson(),
    };
  }

  /// Converts the `Book` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      BookAttributes.id.name: id,
      BookAttributes.isbn.name: isbn,
      BookAttributes.title.name: title,
      BookAttributes.authors.name: authors,
      BookAttributes.synopsis.name: synopsis,
      BookAttributes.image.name: image,
      BookAttributes.publisher.name: publisher,
      BookAttributes.userId.name: userId,
      BookAttributes.condition.name: condition,
      BookAttributes.value.name: value,
      BookAttributes.status.name: status,
      'user': user?.toJson(),
    };
  }

  /// Factory method to create an empty `Book` instance with default values.
  factory Book.empty() {
    return Book(
      id: BookAttributes.id.name,
      isbn: BookAttributes.isbn.name,
      title: BookAttributes.title.name,
      authors: [],
      synopsis: BookAttributes.synopsis.name,
      image: BookAttributes.image.name,
      publisher: BookAttributes.publisher.name,
      userId: BookAttributes.userId.name,
      condition: 0,
      value: 0,
    );
  }

  /// Creates a list of [Book] instances from a list of JSON objects with a nested 'book' key.
  static List<Book> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Book.fromJson(json)).toList();
  }

  /// Creates a list of [Book] instances from a list of JSON objects without a nested 'book' key.
  static List<Book> fromJsonListWithoutKey(List<dynamic> jsonList) {
    return jsonList.map((json) => Book.fromJsonWithoutKey(json)).toList();
  }
}
