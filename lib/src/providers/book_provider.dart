import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleBookProvider = Provider<Book>(
  (ref) => Book(
    id: '9',
    isbn: '9781400079988',
    title: 'War and Peace',
    authors: ['Leo Tolstoy'],
    image:
        'https://m.media-amazon.com/images/I/91n8sen+w1L._AC_UF1000,1000_QL80_.jpg',
    userId: '3',
    synopsis: "",
    publisher: "",
    condition: 5,
    value: 45,
  ),
);

final emptyBookProvider = Provider<Book>(
  (ref) => Book(
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
  ),
);
