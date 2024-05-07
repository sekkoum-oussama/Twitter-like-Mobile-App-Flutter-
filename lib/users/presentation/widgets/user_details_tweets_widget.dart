import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweets_list_bloc/tweets_bloc.dart';
import 'package:twitter_demo/home/presentation/widgets/quote_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/retweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_widget.dart';
import 'package:twitter_demo/home/presentation/widgets/tweets_list_empty.dart';
import 'package:twitter_demo/home/presentation/widgets/tweets_list_error.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';

class UserDetailsTweetsSliverWidget extends StatefulWidget {
  UserDetailsTweetsSliverWidget(this.username, {super.key});
  String username;

  @override
  State<UserDetailsTweetsSliverWidget> createState() =>
      _UserDetailsTweetsSliverWidgetState();
}

class _UserDetailsTweetsSliverWidgetState
    extends State<UserDetailsTweetsSliverWidget> {
  final ScrollController _scrollController = ScrollController();

  List? _tweets = [];
  @override
  void initState() {
    /*_scrollController.addListener(() {
      var nextTweetsTrigger = _scrollController.position.maxScrollExtent * 0.8;
      if (_scrollController.position.pixels > nextTweetsTrigger) {
        _tweetsBloc.add(GetTweets());
      }
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TweetsListBloc()..add(GetTweets(username: widget.username)),
      child: BlocConsumer<TweetsListBloc, TweetsBlocState>(
        //bloc: _tweetsBloc,
        listener: (context, state) {
          if (state is TweetsListNotAuthenticatedError) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          }
          if (state is OldestTweetsLoaded) {
            _tweets!.addAll(state.tweets);
          } else if (state is NewestTweetsLoaded) {
            _tweets!.insertAll(0, state.tweets);
          } else if(state is TweetsListDeleteTweetState) {
            _tweets!.removeWhere((tweet) => tweet.url == state.tweetUrl);
          }
        },
        builder: (context, state) {
          if (_tweets!.isEmpty) {
            if (state is TweetsListLoading) {
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is TweetsListUnknownError) {
              return SliverToBoxAdapter(
                  child: TweetsListError(username: widget.username));
            }
            return SliverToBoxAdapter(
                child: TweetsListEmpty(username: widget.username,
            ));
          }
          return BlocListener<DeleteTweetCubit, DeleteTweetState>(
            listener: (context, state) {
              if(state is TweetDeleted) {
                context.read<TweetsListBloc>().add(TweetDeleteEvent(state.tweetUrl));
              }
            },
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index.isOdd) {
                    // Odd indices are the separators
                    return const Divider(
                      thickness: 1,
                    );
                  } else {
                    // Even indices are the tweet widgets
                    final tweetIndex = (index / 2).floor();
                    switch (_tweets![tweetIndex].type) {
                      case 'reply':
                        return ReplyTweetWidget(_tweets![tweetIndex]);
                      case 'quote':
                        return QuoteTweetWidget(_tweets![tweetIndex]);
                      case 'retweet':
                        return RetweetWidget(_tweets![tweetIndex]);
                      default:
                        return TweetWidget(_tweets![tweetIndex]);
                    }
                  }
                },
                childCount: _tweets!.length * 2 - 1,
              ),
            ),
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
