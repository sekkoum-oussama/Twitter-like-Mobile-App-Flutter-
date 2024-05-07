import 'package:flutter/material.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_options_modal.dart';

class TweetSettingsButton extends StatelessWidget {
  const TweetSettingsButton(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showTweetOptions(context, tweet), 
      icon: const Icon(Icons.more_vert_outlined)
    );
  }
}