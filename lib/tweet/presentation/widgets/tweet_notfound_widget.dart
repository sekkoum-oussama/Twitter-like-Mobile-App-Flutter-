import 'package:flutter/material.dart';


class TweetDetailsNotFoundWidget extends StatelessWidget {
  const TweetDetailsNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 180, horizontal: 30),
      child: const Text("The tweet you're looking for doesn't exist.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
    );
  }
}