import 'package:flutter/material.dart';
import 'package:twitter_demo/home/data/models/retweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quoted_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_to_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/retweet_text_header_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_duration.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_settings_button.dart';


class RetweetWidget extends StatelessWidget {
  RetweetWidget(this.tweet, {super.key});
  ReTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/tweetDetails", arguments: tweet); 
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(14, 5, 11, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RetweetTextWidget(tweet.author),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweetAuthorAvatar(tweet.related_to!.author!['avatar'], tweet.related_to!.author!['url']),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            TweetAuthorUsername(tweet.related_to!.author!['username']),
                            TweetDuration(tweet.related_to!.date),
                            const Spacer(),
                            TweetSettingsButton(tweet.related_to)
                          ],
                        ),
                        tweet.related_to!.reply_to != null ? ReplyToWidget(tweet.related_to!.reply_to!) : const SizedBox(),
                        tweet.related_to!.text != null ? TweetText(tweet.related_to!.text) : const SizedBox(),
                        tweet.related_to!.media!.isEmpty == false ? TweetMedia(tweet.related_to!) : const SizedBox(),
                        tweet.related_to!.quoted_tweet != null ? QuotedTweetWidget(tweet.related_to!.quoted_tweet!) : const SizedBox(),
                        TweetMenu(tweet.related_to!)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      
    );
  }
}
