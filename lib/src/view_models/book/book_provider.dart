import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

final userBooksProvider = StateProvider<List<Book>>((ref) => List.empty());

final bookInfoProvider = StateProvider<Book>((ref) => Book.empty());

final isbnBookRetrievedProvider = StateProvider.autoDispose<Book>(
  (ref) => Book.empty(),
);
