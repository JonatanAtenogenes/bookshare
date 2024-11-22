import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user/api_show_user_provider.dart';
import '../view_models/user/user_provider.dart';

class UserData {
  Future<void> getAuthUserInformation(Ref ref) async {
    try {
      //
      String id = ref.read(currentUserProvider).id;
      await ref.read(apiShowUserNotifierProvider.notifier).showUser(id);
      ref.read(currentUserProvider.notifier).update(
          (state) => state = ref.read(apiShowUserNotifierProvider).data!);
      log(ref.read(apiShowUserNotifierProvider).data.toString());
    } catch (e) {
      //
      log('Error: ${e.toString()}');
    } finally {
      //
    }
  }
}
