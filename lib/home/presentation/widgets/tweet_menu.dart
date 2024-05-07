import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';

import '../../business_logic/tweet_bloc/tweet_bloc.dart';

class TweetMenu extends StatelessWidget {
  TweetMenu(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(top: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TweetReplieButton(tweet),
          TweetRetweetButton(tweet),
          TweetLikeButton(tweet),
          const TweetShareButton(),
        ],
      ),
    );
  }
}

class TweetReplieButton extends StatelessWidget {
  TweetReplieButton(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 22, 0),
        child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 20,
                  color: Color.fromARGB(255, 123, 118, 118),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text("${tweet.replies}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 123, 118, 118))),
              ],
            ),
            onTap: () async {
              dynamic addReplyBloc;
              try {
                addReplyBloc = context.read<AddReplyBloc>();
              } catch(e) {
                addReplyBloc = null;
              }
              final isReplysent = await Navigator.of(context)
                  .pushNamed("/replyToTweet", arguments: {"tweet":tweet, "addReplyBloc":addReplyBloc} );
              if (isReplysent == true) {
                // ignore: use_build_context_synchronously
                Flushbar(
                  margin: const EdgeInsets.only(top: 6, left: 2, right: 2),
                  positionOffset: 5,
                  message: "Reply sent",
                  messageColor: Theme.of(context).textTheme.bodyText1!.color,
                  icon: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.lightBlue,
                      child: Icon(
                        Icons.done_outlined,
                        size: 13,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                      )),
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(8),
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(255, 204, 224, 255)
                          : const Color.fromARGB(255, 11, 41, 66),
                ).show(context);
              }
            }));
  }
}

class TweetRetweetButton extends StatelessWidget {
  TweetRetweetButton(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 22),
      child: BlocConsumer<TweetRetweetCubit, TweetRetweetState>(
        buildWhen: (previous, current) {
          if (current is TweetRetweeted || current is TweetUnretweeted) {
            return tweet.id == current.id;
          } else {
            return false;
          }
        },
        listenWhen: (previous, current) {
          if (current is TweetRetweeted || current is TweetUnretweeted) {
            return tweet.id == current.id;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state is TweetNotFound) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("This tweet does not exist anymore")));
          } else if (state is TweetRetweetError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("An error occured, try later")));
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                      )
                    ),
                    builder: (context) => QuoteOrRetweetBottomModal(tweet));
                },
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.repeat,
                      size: 20,
                      color: tweet.is_retweeted
                          ? Colors.green
                          : const Color.fromARGB(255, 123, 118, 118),
                    )),
              ),
              const SizedBox(
                width: 3,
              ),
              Text("${tweet.interactions}",
                  style: TextStyle(
                      color: tweet.is_retweeted
                          ? Colors.green
                          : const Color.fromARGB(255, 123, 118, 118))),
            ],
          );
        },
      ),
    );
  }
}

class TweetLikeButton extends StatelessWidget {
  TweetLikeButton(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TweetLikedBloc, TweetState>(
      
      buildWhen: (old, current) {
        if (current is TweetLikedState || current is TweetUnlikedState) {
          return tweet.id == current.id;
        }
        return false;
      },
      listener: (context, state) {
        if (state is TweetLikeNotFoundState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "The tweet you're trying to interact with doesn't exist anymore")));
        } else if (state is TweetLikeErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something went wrong, please try later...")));
        }
      },
      builder: (context, state) {
        /*if(state is TweetLikedState) {
          likes = likes! + 1;
        } */
        return Container(
          margin: const EdgeInsets.only(right: 22),
          child: GestureDetector(
            child: Row(
              children: [
                Icon(
                  tweet.is_liked
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  size: 20,
                  color: tweet.is_liked
                      ? Colors.red
                      : const Color.fromARGB(255, 123, 118, 118),
                ),
                const SizedBox(width: 3),
                Text(
                  "${tweet.likes}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 123, 118, 118),
                  ),
                ),
              ],
            ),
            onTap: () async => {
              tweet.is_liked
                  ? BlocProvider.of<TweetLikedBloc>(context)
                      .add(TweetUnLikeEvent(tweet.id))
                  : BlocProvider.of<TweetLikedBloc>(context)
                      .add(TweetLikeEvent(tweet.id))
            },
          ),
        );
      },
    );
  }
}

class TweetShareButton extends StatelessWidget {
  const TweetShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Row(
        children: [
          Icon(
            Icons.share_outlined,
            size: 20,
            color: Color.fromARGB(255, 123, 118, 118),
          ),
        ],
      ),
      onTap: () => {},
    );
  }
}

class QuoteOrRetweetBottomModal extends StatelessWidget {
  QuoteOrRetweetBottomModal(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    // Wrap widget is to make the bottomSheet's height dynamic
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25, bottom: 30, top: 30),
          child: DefaultTextStyle(
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyMedium!.color
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    tweet.is_retweeted
                      ? context
                          .read<TweetRetweetCubit>()
                          .deleteRetweet(tweet.id)
                      : context
                          .read<TweetRetweetCubit>()
                          .tweetRetweet(tweet.id);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.repeat,
                          size: 28,
                          color: tweet.is_retweeted
                              ? Colors.green
                              : Colors.grey[600]),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(tweet.is_retweeted ? "Unpost" : "Repost"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final tweetAsJson = tweet.toJson();
                    QuotedTweetModel quotedTweet = QuotedTweetModel.fromJson(tweetAsJson);
                    final isTweetSent = await Navigator.of(context).pushNamed("/quoteTweet", arguments: quotedTweet);
                    Navigator.of(context).pop();
                    if (isTweetSent == true) {
                      
                    // ignore: use_build_context_synchronously
                    Flushbar(
                      margin: const EdgeInsets.only(top: 6, left: 2, right: 2),
                      positionOffset: 5,
                      message: "Your Post Was Sent",
                      messageColor: Theme.of(context).textTheme.bodyText1!.color,
                      icon: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(
                            Icons.done_outlined,
                            size: 13,
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                          )),
                      duration: const Duration(seconds: 3),
                      borderRadius: BorderRadius.circular(8),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 204, 224, 255)
                              : const Color.fromARGB(255, 11, 41, 66),
                      ).show(context);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 28,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("Quote"),
                    ],
                  ),
                ),
              ],
            ),
          ),
              
        ),
      ],
    );
  }
}
