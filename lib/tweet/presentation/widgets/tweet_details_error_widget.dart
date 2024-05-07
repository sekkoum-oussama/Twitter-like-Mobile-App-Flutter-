import 'package:flutter/material.dart';


class TweetDetailsErrorWidget extends StatelessWidget {
  const TweetDetailsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
      child: const Text("OOPS! there seems to be an error loading the data, please try later", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
    );
  }
}