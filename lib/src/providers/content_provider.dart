import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexContentProvider = StateProvider<int>((ref) => 0);

final loadingContentProvider = StateProvider<bool>((ref) => false);
