import 'package:flutter/material.dart';


class TweetInteractions extends StatelessWidget {
  TweetInteractions(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          HelperWidget(tweet.retweets, "Retweets", "/retweetsList", tweet.id),
          HelperWidget(tweet.quotes, "Quotes", "/quotesList", tweet.id),
          HelperWidget(tweet.likes, "Likes", "/likesList", tweet.id),
        ],
      ),
    );
  }
}


class HelperWidget extends StatelessWidget {
  HelperWidget(this.number, this.label, this.url, this.id, {super.key});
  int number;
  String label;
  String url;
  int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(url, arguments: id),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$number ",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: label,
                style: const TextStyle(color: Color.fromARGB(255, 96, 93, 93)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}