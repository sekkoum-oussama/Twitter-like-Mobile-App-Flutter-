import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweets_list_bloc/tweets_bloc.dart';
import 'package:twitter_demo/home/presentation/widgets/quote_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/retweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_widget.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';
import 'package:twitter_demo/utils/update_tweets_list_interactions.dart';

class NewsFeedTweets extends StatefulWidget {
  NewsFeedTweets(this._tweets, this._handleScrolling, {super.key});
  final List _tweets;
  Function _handleScrolling;

  @override
  State<NewsFeedTweets> createState() => _NewsFeedTweetsState();
}

class _NewsFeedTweetsState extends State<NewsFeedTweets> {
  final ScrollController _scrollController = ScrollController();
  bool? isLoadingOldTweets;
  bool? isLastTweetReached;

  @override
  void initState() {
    isLoadingOldTweets = false;
    isLastTweetReached = false;
    _scrollController.addListener(() {
      widget._handleScrolling(_scrollController);
      var nextTweetsTrigger = _scrollController.position.maxScrollExtent * 0.8;
      if (_scrollController.position.pixels > nextTweetsTrigger) {
        if (isLoadingOldTweets == false && isLastTweetReached == false)
          _loadOlderTweets();
      }
    });
    super.initState();
  }

  _loadOlderTweets() async {
    setState(() {
      isLoadingOldTweets = true;
    });
    final lastTweetId = widget._tweets.last.id;
    final tweetsBloc = context.read<TweetsListBloc>()
      ..add(GetTweets(order: "oldest", id: lastTweetId));
    tweetsBloc.stream.listen((emittedState) {
      if (emittedState is! TweetsListBlocInitial &&
          emittedState is! TweetsListLoading) {
        setState(() {
          isLoadingOldTweets = false;
        });
        if (emittedState is OldestTweetsLoaded) {
          if (emittedState.tweets.isEmpty) {
            setState(() {
              isLastTweetReached = true;
            });
          }
        }
      }
    });
  }

  _loadNewTweets() async {
    if (widget._tweets.isNotEmpty) {
      final firstTweetId = widget._tweets.first.id;
      final tweetsBloc = context.read<TweetsListBloc>()
        ..add(GetTweets(order: "newest", id: firstTweetId));
      tweetsBloc.stream.listen((emittedState) {
        if (emittedState is! TweetsListBlocInitial &&
            emittedState is! TweetsListLoading) return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpdateTweetsInteractions(
      tweets: widget._tweets,
      child: SliverFillRemaining(
        child: RefreshIndicator(
          onRefresh: () async => await _loadNewTweets(),
          child: ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (BuildContext context, int tweetIndex) {
              switch (widget._tweets[tweetIndex].type) {
                case 'reply':
                  return ReplyTweetWidget(widget._tweets[tweetIndex]);
                case 'quote':
                  return QuoteTweetWidget(widget._tweets[tweetIndex]);
                case 'retweet':
                  return RetweetWidget(widget._tweets[tweetIndex]);
                default:
                  return TweetWidget(widget._tweets[tweetIndex]);
              }
            },
            itemCount: widget._tweets.length,
          ),
        ),
      ),
    );
  }
}
