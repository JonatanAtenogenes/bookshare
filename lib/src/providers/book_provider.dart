import 'package:bookshare/src/models/book/book.dart';
import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleBookProvider = Provider<Book>(
  (ref) => Book(
    id: '9',
    isbn: '9781400079988',
    title: 'War and Peace',
    authors: ['Leo Tolstoy'],
    image:
        'https://m.media-amazon.com/images/I/91n8sen+w1L._AC_UF1000,1000_QL80_.jpg',
    synopsis:
        "War and Peace centers broadly on Napoleon’s invasion of Russia in 1812 and follows three of the best-known characters in literature: Pierre Bezukhov, the illegitimate son of a count who is fighting for his inheritance and yearning for spiritual fulfillment; Prince Andrei Bolkonsky, who leaves behind his family to fight in the war against Napoleon; and Natasha Rostov, the beautiful young daughter of a nobleman, who intrigues both men. As Napoleon’s army invades, Tolstoy vividly follows characters from diverse backgrounds—peasants and nobility, civilians and soldiers—as they struggle with the problems unique to their era, their history, and their culture. And as the novel progresses, these characters transcend their specificity, becoming some of the most moving—and human—figures in world literature.",
    publisher: "",
    condition: 5,
    value: 45,
    user: User.empty(),
  ),
);

final emptyBookProvider = Provider<Book>(
  (ref) => Book(
    id: BookAttributes.id.name,
    isbn: BookAttributes.isbn.name,
    title: BookAttributes.title.name,
    authors: [],
    image: BookAttributes.image.name,
    synopsis: BookAttributes.synopsis.name,
    publisher: BookAttributes.publisher.name,
    condition: 0,
    value: 0,
    user: User.empty(),
  ),
);
