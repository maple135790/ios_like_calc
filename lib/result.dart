import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String display;

  Result({Key? key, this.display = '0'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text(display, style: TextStyle(fontSize: 48))],
        ),
      ),
    );
  }
}
