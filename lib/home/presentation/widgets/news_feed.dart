import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweets_list_bloc/tweets_bloc.dart';
import 'package:twitter_demo/home/presentation/widgets/news_feed_tweets.dart';
import 'package:twitter_demo/home/presentation/widgets/tweets_list_empty.dart';
import 'package:twitter_demo/home/presentation/widgets/tweets_list_error.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';

class NewsFeed extends StatefulWidget {
  NewsFeed(this._handleScrolling, {super.key});
  Function _handleScrolling;

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final ScrollController _scrollController = ScrollController();
  List _tweets = [];
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TweetsListBloc()..add(GetTweets()),
      child: BlocConsumer<TweetsListBloc, TweetsBlocState>(
        listener: (context, state) {
          if (state is TweetsListNotAuthenticatedError) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          }
          if (state is OldestTweetsLoaded) {
            _tweets.addAll(state.tweets);
          } else if (state is NewestTweetsLoaded) {
            _tweets.insertAll(0, state.tweets);
          } else if(state is TweetsListDeleteTweetState) {
            _tweets.removeWhere((tweet) => tweet.url == state.tweetUrl);
          }
        },
        builder: (context, state) {
          if (_tweets.isEmpty) {
            if (state is TweetsListLoading) {
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is TweetsListUnknownError) {
              return SliverToBoxAdapter(
                  child: TweetsListError());
            } else if (state is OldestTweetsLoaded || state is NewestTweetsLoaded) {
              return SliverToBoxAdapter(
                  child: TweetsListEmpty()
              );
            }
            return const SliverToBoxAdapter(child: SizedBox());
          }
          return BlocListener<DeleteTweetCubit, DeleteTweetState>(
            listener: (context, state) {
              if(state is TweetDeleted) {
                context.read<TweetsListBloc>().add(TweetDeleteEvent(state.tweetUrl));
              }
            },
            child: NewsFeedTweets(_tweets, widget._handleScrolling),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
