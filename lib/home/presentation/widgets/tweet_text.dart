import 'package:flutter/material.dart';


class TweetText extends StatelessWidget {
  TweetText(this.text, [this.fontSize = 15.0, Key? key]) : super(key: key);
  String? text;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Text(text!, style: TextStyle(fontSize: this.fontSize),),
    );
  }
}