import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
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

import '../../business_logic/tweet_bloc/tweet_bloc.dart';

class QuoteTweetWidget extends StatelessWidget {
  QuoteTweetWidget(this.tweet, {super.key});
  QuoteTweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/tweetDetails", arguments: tweet); 
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(14, 5, 11, 5),
          child: 
              Row(
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
                            TweetSettingsButton(tweet),
                          ],
                        ),
                        tweet.text != null ? TweetText(tweet.text) : Container(),
                        tweet.media!.isEmpty == false ? TweetMedia(tweet) : Container(),
                        tweet.quoted_tweet != null ? QuotedTweetWidget(tweet.quoted_tweet!) : Container(),
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
