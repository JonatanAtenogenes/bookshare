import 'enum/book_attributes.dart';

class Book {
  String? _id;
  String? _isbn;
  String? _title;
  List<String>? _authors;
  String? _synopsis;
  String? _image;
  String? _publisher;
  String? _userId;
  int? _condition; // The condition can change over time
  int? _value; // The value can increment or decrement
  bool _status = true; // Available or not available

  // Constructor
  Book({
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
    bool status = true,
  }) {
    _id = id;
    _isbn = isbn;
    _title = title;
    _authors = authors;
    _synopsis = synopsis;
    _image = image;
    _publisher = publisher;
    _userId = userId;
    _condition = condition;
    _value = value;
    _status = status;
  }

  // Setters
  void setId(String id) {
    _id = id;
  }

  void setIsbn(String isbn) {
    _isbn = isbn;
  }

  void setTitle(String title) {
    _title = title;
  }

  void setAuthors(List<String> authors) {
    _authors = authors;
  }

  void setSynopsis(String synopsis) {
    _synopsis = synopsis;
  }

  void setImage(String image) {
    _image = image;
  }

  void setPublisher(String publisher) {
    _publisher = publisher;
  }

  void setUserId(String userId) {
    _userId = userId;
  }

  void setCondition(int condition) {
    _condition = condition;
  }

  void setValue(int value) {
    _value = value;
  }

  void setStatus(bool status) {
    _status = status;
  }

  // Getter for the donation as a map
  Map<String, dynamic> get book {
    return {
      BookAttributes.id.name: _id,
      BookAttributes.isbn.name: _isbn,
      BookAttributes.title.name: _title,
      BookAttributes.authors.name: _authors,
      BookAttributes.synopsis.name: _synopsis,
      BookAttributes.image.name: _image,
      BookAttributes.publisher.name: _publisher,
      BookAttributes.userId.name: _userId,
      BookAttributes.condition.name: _condition,
      BookAttributes.value.name: _value,
      BookAttributes.status.name: _status,
    };
  }
}
