import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TitleText(title: 'Pagina no encontrada'),
      ),
    );
  }
}
