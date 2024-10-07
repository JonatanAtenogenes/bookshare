import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:bookshare/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appTitle,
      theme: GlobalThemeData.lightThemeData,
      themeMode: ThemeMode.system,
      darkTheme: GlobalThemeData.darkThemeData,
      routerConfig: routes,
    );
  }
}
