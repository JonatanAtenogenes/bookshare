import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StateProvider<User>((ref) => User.empty());
