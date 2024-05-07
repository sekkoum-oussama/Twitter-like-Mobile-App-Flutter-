import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/home/data/models/retweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quoted_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_to_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/retweet_text_header_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_interactions.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_settings_button.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_time.dart';


class RetweetDetails extends StatelessWidget {
  RetweetDetails(this.tweet, {super.key});
  ReTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RetweetTextWidget(tweet.author),
            Row(
              children: [
                TweetAuthorAvatar(tweet.related_to!.author!['avatar'], tweet.related_to!.author!['url']),
                TweetAuthorUsername(tweet.related_to!.author!['username']),
                const Spacer(),
                TweetSettingsButton(tweet.related_to),
              ],
            ),
            tweet.related_to!.reply_to != null ? ReplyToWidget(tweet.related_to!.reply_to!) : Container(),
            tweet.related_to!.text != null ? TweetText(tweet.related_to!.text, 18) : const SizedBox(),
            TweetMedia(tweet.related_to!),
            tweet.related_to!.quoted_tweet != null ? QuotedTweetWidget(tweet.related_to!.quoted_tweet!) : Container(),
            TweetTime(tweet.related_to!.date),
            const Divider(thickness: 0.6,),
            TweetInteractions(tweet.related_to!),
            Divider(thickness: 0.6,),
            TweetMenu(tweet.related_to!),
          ],
        ),
      
    );
  }
}