import 'package:flutter/widgets.dart';

class VisualizeData extends StatelessWidget {
  const VisualizeData({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 10),
      child: Text('$title: $data'),
    );
  }
}
