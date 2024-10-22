import 'package:bookshare/src/models/book.dart';
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
