import 'package:bookshare/src/models/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleUserProvider = Provider<User>((ref) => User.empty());
