import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book/book.dart';

final userBooksProvider = StateProvider<List<Book>>((ref) => List.empty());
