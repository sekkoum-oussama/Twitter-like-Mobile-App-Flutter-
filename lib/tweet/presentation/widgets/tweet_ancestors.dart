import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/presentation/widgets/quote_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/retweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_widget.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_ancestors_bloc/tweet_ancestors_bloc.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_ancestors_error.dart';
import 'package:twitter_demo/utils/update_tweets_list_interactions.dart';

class TweetAncestors extends StatefulWidget {
  TweetAncestors(this.id, {super.key});
  int id;

  @override
  State<TweetAncestors> createState() => _TweetAncestorsState();
}

class _TweetAncestorsState extends State<TweetAncestors> {
  List _tweets = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TweetAncestorsBloc()..add(GetTweetAncestors(widget.id)),
      child: BlocConsumer<TweetAncestorsBloc, TweetAncestorsState>(
        listener: (context, state) {
          if (state is TweetAncestorsLoaded) {
            _tweets.insertAll(0, state.tweets);
          }
        },
        builder: (context, state) {
          if (_tweets.isEmpty) {
            if (state is TweetAncestorsError) {
              return TweetLoadingAncestorsErrorWidget(
                  context.read<TweetAncestorsBloc>(), widget.id);
            } else {
              return SliverToBoxAdapter(
                child: const SizedBox(),
              );
            }
          }
          return BlocListener<DeleteTweetCubit, DeleteTweetState>(
            listener: (context, state) {
              if(state is TweetDeleted) {
                if(_tweets.any((tweet) => tweet.url == state.tweetUrl)) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: UpdateTweetsInteractions(
              tweets: _tweets,
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index.isOdd) {
                      // Odd indices are the separators
                      return const Divider();
                    } else {
                      // Even indices are the tweet widgets
                      final tweetIndex = (index / 2).floor();
                      switch (_tweets[tweetIndex].type) {
                        case 'reply':
                          return ReplyTweetWidget(_tweets[tweetIndex]);
                        case 'quote':
                          return QuoteTweetWidget(_tweets[tweetIndex]);
                        case 'retweet':
                          return RetweetWidget(_tweets[tweetIndex]);
                        default:
                          return TweetWidget(_tweets[tweetIndex]);
                      }
                    }
                  },
                  childCount: _tweets.length * 2 - 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TweetAncestorsListWidgets extends StatelessWidget {
  TweetAncestorsListWidgets(this.tweets, {super.key});
  List tweets;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd) {
            // Odd indices are the separators
            return const Divider();
          } else {
            // Even indices are the tweet widgets
            final tweetIndex = (index / 2).floor();
            switch (tweets[tweetIndex].type) {
              case 'reply':
                return ReplyTweetWidget(tweets[tweetIndex]);
              case 'quote':
                return QuoteTweetWidget(tweets[tweetIndex]);
              case 'retweet':
                return RetweetWidget(tweets[tweetIndex]);
              default:
                return TweetWidget(tweets[tweetIndex]);
            }
          }
        },
        childCount: tweets.length * 2 - 1,
      ),
    );
  }
}
