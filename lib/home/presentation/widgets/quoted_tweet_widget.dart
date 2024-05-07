import 'package:flutter/material.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quoted_user_avatar.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_to_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_duration.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';

class QuotedTweetWidget extends StatelessWidget {
  QuotedTweetWidget(this.tweet, {super.key});
  QuotedTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
            Navigator.pushNamed(context, "/tweetDetails", arguments: tweet); 
          },
        child: Container(
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(5))
          ),
          padding: const EdgeInsets.fromLTRB(7, 6, 7, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  QuotedUserAvatar(tweet.author!['avatar']),
                  Text(tweet.author!['username'], style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  TweetDuration(tweet.date),
                ],
              ),
              tweet.reply_to != null ? ReplyToWidget(tweet.reply_to!) : Container(),
              tweet.text != null ? TweetText(tweet.text) : Container(),
              tweet.media!.isEmpty == false ? TweetMedia(tweet) : Container(),
            ],
          ),
        ),
      
    );
  }
}
