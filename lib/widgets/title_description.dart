import 'package:flutter/material.dart';

class TitleDescription extends StatelessWidget {

  String title;
  String subTitle;

  TitleDescription({
    required this.title,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 16.0)),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(top: 12.0)),
        Text(
          subTitle,
          style: const TextStyle(color: Colors.white, fontSize: 12.0),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}