import 'package:flutter/material.dart';

class NoRecordsText extends StatelessWidget {
  final String text;

  const NoRecordsText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Text(text)));
  }
}
