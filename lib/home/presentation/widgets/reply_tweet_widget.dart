import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/home/data/models/tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_to_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_duration.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_settings_button.dart';

import '../../business_logic/tweet_bloc/tweet_bloc.dart';

class ReplyTweetWidget extends StatelessWidget {
  ReplyTweetWidget(this.tweet, {super.key});
  ReplyTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/tweetDetails", arguments: tweet); 
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(14, 5, 11, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweetAuthorAvatar(tweet.author!['avatar'], tweet.author!['url']),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        TweetAuthorUsername(tweet.author!['username']),
                        TweetDuration(tweet.date),
                        const Spacer(),
                        TweetSettingsButton(tweet)
                      ],
                    ),
                    tweet.reply_to != null ? ReplyToWidget(tweet.reply_to) : Container(),
                    tweet.text != null ? TweetText(tweet.text) : const SizedBox(),
                    TweetMedia(tweet),
                    TweetMenu(tweet)
                  ],
                ),
              )
            ],
          ),
        ),
      
    );
  }
}
