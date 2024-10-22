import 'enum/enums.dart';

class Book {
  final String id;
  final String isbn;
  final String title;
  final List<String> authors;
  final String synopsis;
  final String image;
  final String publisher;
  final String userId;
  final int condition; // The condition can change over time
  final int value; // The value can increment or decrement
  final bool status = true; // Available or not available

  // Constructor
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

  // CopyWith
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

  // Getter for the donation as a map
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
}
