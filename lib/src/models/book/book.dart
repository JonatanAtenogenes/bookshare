import 'dart:developer';

import '../enum/book_attributes.dart';
import '../enum/enums.dart';

/// Represents a book with various attributes and methods to manage its data.
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

  /// Constructor for the `Book` class.
  ///
  /// [id] - Unique identifier for the book.
  /// [isbn] - ISBN of the book.
  /// [title] - Title of the book.
  /// [authors] - List of authors.
  /// [synopsis] - Synopsis of the book.
  /// [image] - Image URL of the book.
  /// [publisher] - Publisher of the book.
  /// [userId] - User ID associated with the book.
  /// [condition] - Condition of the book.
  /// [value] - Value of the book.
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
  });

  /// Creates a copy of the current `Book` instance with updated fields.
  ///
  /// Returns a new instance of `Book` with updated attributes specified.
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
    );
  }

  /// Factory method to create a `Book` instance from a JSON map.
  ///
  /// [json] - JSON map representing a book.
  /// Returns a `Book` instance populated with data from the JSON.
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
    );
  }

  /// Getter for the book attributes as a map.
  ///
  /// Returns a map representation of the book attributes,
  /// which can be useful for serialization.
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
    };
  }

  /// Factory method to create an empty `Book` instance with default values.
  ///
  /// Returns a `Book` instance where all attributes are set to default values.
  factory Book.empty() {
    return Book(
      id: BookAttributes.id.name,
      isbn: BookAttributes.isbn.name,
      title: BookAttributes.title.name,
      authors: [],
      image: BookAttributes.image.name,
      userId: BookAttributes.userId.name,
      synopsis: BookAttributes.synopsis.name,
      publisher: BookAttributes.publisher.name,
      condition: 0,
      value: 0,
    );
  }
}