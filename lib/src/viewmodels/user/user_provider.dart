import 'package:bookshare/src/models/api/file_response.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StateProvider<User>((ref) => User.empty());

final uploadedImageDataProvider = StateProvider<FileResponse>(
  (ref) => FileResponse.empty(),
);
