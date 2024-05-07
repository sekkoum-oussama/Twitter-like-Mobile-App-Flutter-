import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';

class UpdateTweetsInteractions extends StatelessWidget {
  UpdateTweetsInteractions({required this.child, required this.tweets, super.key});
  List? tweets;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TweetLikedBloc, TweetState>(
      listener: (context, state) {
        if (state is TweetLikedState) {
          tweets!.forEach((tweet) {
            if (tweet.type == "retweet") {
              if (tweet.related_to.id == state.id) {
                tweet.related_to.likes++;
                tweet.related_to.is_liked = true;
              }
            } else {
              if (tweet.id == state.id) {
                tweet.likes++;
                tweet.is_liked = true;
              }
            }
          });
        } else if (state is TweetUnlikedState) {
          tweets!.forEach((tweet) {
            if (tweet.type == "retweet") {
              if (tweet.related_to.id == state.id) {
                tweet.related_to.likes--;
                tweet.related_to.is_liked = false;
              }
            } else {
              if (tweet.id == state.id) {
                tweet.likes--;
                tweet.is_liked = false;
              }
            }
          });
        }
      },
      child: BlocListener<TweetRetweetCubit, TweetRetweetState>(
        listener: (context, state) {
          if (state is TweetRetweeted) {
          tweets!.forEach((tweet) {
            if (tweet.type == "retweet") {
              if (tweet.related_to.id == state.id) {
                tweet.related_to.interactions++;
                tweet.related_to.is_retweeted = true;
              }
            } else {
              if (tweet.id == state.id) {
                tweet.interactions++;
                tweet.is_retweeted = true;
              }
            }
          });
        } else if (state is TweetUnretweeted) {
          tweets!.forEach((tweet) {
            if (tweet.type == "retweet") {
              if (tweet.related_to.id == state.id) {
                tweet.related_to.interactions--;
                tweet.related_to.is_retweeted = false;
              }
            } else {
              if (tweet.id == state.id) {
                tweet.interactions--;
                tweet.is_retweeted = false;
              }
            }
          });
        }
        },
        child: child,
      ),
    );
  }
}