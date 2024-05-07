import 'package:flutter/material.dart';

class TweetDuration extends StatelessWidget {
  TweetDuration(this.time, {super.key});
  String? time;

  String getTweetDuration(String time) {
    DateTime tweetTime = DateTime.parse(time);
    tweetTime = DateTime.utc(tweetTime.year, tweetTime.month, tweetTime.day, tweetTime.hour, tweetTime.minute, tweetTime.second);
    DateTime currentTime = DateTime.now().toUtc();
    Duration tweetDuration = currentTime.difference(tweetTime);
    if (tweetDuration.inDays < 365) {
      if (tweetDuration.inHours < 24) {
        if (tweetDuration.inMinutes < 60) {
          return "${tweetDuration.inMinutes > 0 ? tweetDuration.inMinutes : 1}m";
        } else {
          return "${tweetDuration.inMinutes ~/ 60}h";
        }
      } else {
        return "${tweetDuration.inHours ~/ 24}d";
      }
    } else {
      return "${tweetDuration.inDays ~/ 365}y";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        getTweetDuration(time!),
        style: const TextStyle(
          color: Color.fromARGB(255, 115, 112, 112),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}