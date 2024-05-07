import 'package:flutter/material.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quoted_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_interactions.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_settings_button.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_time.dart';


class QuoteTweetDetails extends StatelessWidget {
  QuoteTweetDetails(this.tweet, {super.key});
  QuoteTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TweetAuthorAvatar(tweet.author!['avatar'], tweet.author!['url']),
                TweetAuthorUsername(tweet.author!['username']),
                const Spacer(),
                TweetSettingsButton(tweet),
              ],
            ),
            tweet.text != null ? TweetText(tweet.text, 18) : const SizedBox(),
            TweetMedia(tweet),
            tweet.quoted_tweet != null ? QuotedTweetWidget(tweet.quoted_tweet!) : Container(),
            TweetTime(tweet.date),
            Divider(thickness: 0.6,),
            TweetInteractions(tweet),
            Divider(thickness: 0.6,),
            TweetMenu(tweet),
          ],
        ),
      
    );
  }
}