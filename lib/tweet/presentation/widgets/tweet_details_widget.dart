import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/home/data/models/tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_media.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_text.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';
import 'package:twitter_demo/tweet/presentation/widgets/quote_tweet_details.dart';
import 'package:twitter_demo/tweet/presentation/widgets/reply_to_tweet_textfield.dart';
import 'package:twitter_demo/tweet/presentation/widgets/reply_tweet_details.dart';
import 'package:twitter_demo/tweet/presentation/widgets/retweet_details.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_ancestors.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_interactions.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_replies.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_settings_button.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_time.dart';

class TweetDetailsWidget extends StatefulWidget {
  TweetDetailsWidget(this.tweet, {super.key});
  final tweet;

  @override
  State<TweetDetailsWidget> createState() => _TweetDetailsWidgetState();
}

class _TweetDetailsWidgetState extends State<TweetDetailsWidget> {
  final UniqueKey _center = UniqueKey();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTweetCubit, DeleteTweetState>(
      listener: (context, state) {
        if (state is TweetDeleted) {
          if (state.tweetUrl == widget.tweet.url) {
            Navigator.of(context).pop();
          }
        }
      },
      child: BlocProvider(
        create: (context) => AddReplyBloc(),
        child: BlocListener<TweetRetweetCubit, TweetRetweetState>(
          listener: (context, state) {
            if(state is TweetRetweeted) {
              if(widget.tweet.type == "retweet") {
                if(widget.tweet.related_to.id == state.id) {
                  widget.tweet.related_to.interactions++;
                  widget.tweet.related_to.is_retweeted = true;
                }
              } else {
                if(widget.tweet.id == state.id) {
                  widget.tweet.interactions++;
                  widget.tweet.is_retweeted = true;
                }
              }
            } else if(state is TweetUnretweeted) {
              if(widget.tweet.type == "retweet") {
                if(widget.tweet.related_to.id == state.id) {
                  widget.tweet.related_to.interactions--;
                  widget.tweet.related_to.is_retweeted = false;
                }
              } else {
                if(widget.tweet.id == state.id) {
                  widget.tweet.interactions--;
                  widget.tweet.is_retweeted = false;
                }
              }
            }
          },
          child: BlocListener<TweetLikedBloc, TweetState>(
            listener: (context, state) {
              if(state is TweetLikedState) {
                  if(widget.tweet.type == "retweet") {
                    if(widget.tweet.related_to.id == state.id) {
                      widget.tweet.related_to.likes++;
                      widget.tweet.related_to.is_liked = true;
                    }
                  } else {
                    if(widget.tweet.id == state.id) {
                      widget.tweet.likes++;
                      widget.tweet.is_liked = true;
                    }
                  }
              } else if(state is TweetUnlikedState) {
                if(widget.tweet.type == "retweet") {
                  if(widget.tweet.related_to.id == state.id) {
                    widget.tweet.related_to.likes--;
                    widget.tweet.related_to.is_liked = false;
                  }
                } else {
                  if(widget.tweet.id == state.id) {
                    widget.tweet.likes--;
                    widget.tweet.is_liked = false;
                  }
                }
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    center: _center,
                    slivers: [
                      if (widget.tweet.type == "reply")
                        TweetAncestors(widget.tweet.id)
                      else if (widget.tweet.type == "retweet")
                        if (widget.tweet.related_to!.type == "reply")
                          TweetAncestors(widget.tweet.related_to!.id),
                      SliverToBoxAdapter(
                        key: _center,
                        child: TweetDetailsContent(widget.tweet),
                      ),
                      const SliverToBoxAdapter(
                        child: Divider(
                          thickness: 0.6,
                        ),
                      ),
                      TweetReplies(widget.tweet.type == "retweet"
                          ? widget.tweet.related_to!.id
                          : widget.tweet.id),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                ReplyToTweet(_scrollController, widget.tweet.id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TweetDetailsContent extends StatelessWidget {
  TweetDetailsContent(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    switch (tweet.type) {
      case 'reply':
        return ReplyTweetDetails(tweet);
      case 'quote':
        return QuoteTweetDetails(tweet);
      case 'retweet':
        return RetweetDetails(tweet);
      default:
        return TweetDetails(tweet);
    }
  }
}

class TweetDetails extends StatelessWidget {
  TweetDetails(this.tweet, {super.key});
  TweetModel tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TweetAuthorAvatar(tweet.author!['avatar'], tweet.author!['url']),
              TweetAuthorUsername(tweet.author!['username']),
              const Spacer(),
              TweetSettingsButton(tweet)
            ],
          ),
          tweet.text != null ? TweetText(tweet.text, 18) : const SizedBox(),
          TweetMedia(tweet),
          TweetTime(tweet.date),
          const Divider(
            thickness: 0.6,
          ),
          TweetInteractions(tweet),
          const Divider(
            thickness: 0.6,
          ),
          TweetMenu(tweet),
        ],
      ),
    );
  }
}
