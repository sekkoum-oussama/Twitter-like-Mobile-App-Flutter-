import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/reply_tweet_widget.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_replies_bloc/tweet_replies_bloc.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_replies_error.dart';
import 'package:twitter_demo/utils/update_tweets_list_interactions.dart';

class TweetReplies extends StatefulWidget {
  TweetReplies(this.id, {super.key});
  int id;

  @override
  State<TweetReplies> createState() => _TweetRepliesState();
}

class _TweetRepliesState extends State<TweetReplies> {
  List _tweets = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TweetRepliesBloc()..add(GetTweetReplies(widget.id)),
      child: BlocConsumer<TweetRepliesBloc, TweetRepliesState>(
        listener: (context, state) {
          if(state is TweetRepliesLoaded) {
            _tweets.addAll(state.replies);
          } else if(state is TweetsRepliesDeleteTweetState) {
            _tweets.removeWhere((tweet) => tweet.url == state.tweetUrl);
          }
        },
        builder: (context, state) {
          final addreplyState = context.watch<AddReplyBloc>().state;
          if (addreplyState is AddReplyLoaded && state is TweetRepliesLoaded) {
            if(!_tweets.any((tweet) => tweet.id == addreplyState.reply.id)) {
              _tweets.insert(0, addreplyState.reply);
            }
          }
          if (_tweets.isEmpty) {
            if (state is TweetRepliesError) {
              return TweetLoadingRepliesErrorWidget(
                  context.read<TweetRepliesBloc>(), widget.id);
            } else if (state is TweetRepliesLoading) {
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }
          }
          return BlocListener<DeleteTweetCubit, DeleteTweetState>(
            listener: (context, state) {
              if(state is TweetDeleted) {
                context.read<TweetRepliesBloc>().add(TweetDeleteEvent(state.tweetUrl));
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
                      return ReplyTweetWidget(_tweets[tweetIndex]);
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

class TweetRepliesListWidgets extends StatelessWidget {
  TweetRepliesListWidgets(this.replies, {super.key});
  List<ReplyTweetModel> replies;

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
            return ReplyTweetWidget(replies[tweetIndex]);
          }
        },
        childCount: replies.length * 2 - 1,
      ),
    );
  }
}
