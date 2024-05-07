import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TweetTime extends StatelessWidget {
  TweetTime(this.time, {super.key});
  String? time;

  String getTweetTime(time) {
    DateTime tweetTime = DateTime.parse(time);
    tweetTime = DateTime.utc(tweetTime.year, tweetTime.month, tweetTime.day, tweetTime.hour, tweetTime.minute, tweetTime.second);
    DateTime localTime = tweetTime.toLocal();
    return "${DateFormat('HH:mm').format(localTime)} \u00B7 ${DateFormat('d MMM yy').format(localTime)}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 3),
      child: Text(getTweetTime(time!),
                style: TextStyle(color: Color.fromARGB(255, 96, 93, 93)),
      ),
    );
  }
}