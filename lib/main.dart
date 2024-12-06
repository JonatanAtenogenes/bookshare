import 'package:bookshare/src/routes/routes.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    // wrap the entire app with a ProviderScope so that widgets
    // will be able to read providers
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        theme: GlobalThemeData.lightThemeData,
        themeMode: ThemeMode.system,
        darkTheme: GlobalThemeData.darkThemeData,
        routerConfig: router,
      ),
    );
  }
}
