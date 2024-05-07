import 'package:flutter/material.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_duration.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';


class OriginalTweet extends StatelessWidget {
  OriginalTweet(this.tweet, {super.key});
  final tweet; 

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(tweet.author!["avatar"]),
              ),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TweetAuthorUsername(tweet.author!["username"]),
                      TweetDuration(tweet.date)
                    ],
                  ),
                  if (tweet.text != null) TweetText(tweet.text),
                  TweetMedia(tweet),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}