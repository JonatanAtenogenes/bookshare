import 'package:flutter/material.dart';

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

class SelectInfo extends StatelessWidget {
  const SelectInfo({
    super.key,
    required this.data,
    required this.textButton,
    required this.onPressed,
  });

  final String data;
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(textButton),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectInfoImproved extends SelectInfo {
  const SelectInfoImproved({
    super.key,
    required super.data,
    required this.selectedData,
    required super.textButton,
    required super.onPressed,
  });

  final String selectedData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height / 25,
        vertical: MediaQuery.of(context).size.width / 25,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        )),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(data),
                  Text(selectedData),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(textButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
