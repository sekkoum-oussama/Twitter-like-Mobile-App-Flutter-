import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/home/presentation/widgets/media_from_network.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_author_avatar.dart';
import 'package:twitter_demo/home/presentation/widgets/tweet_menu.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_details_bloc/tweet_details_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';
import 'package:twitter_demo/tweet/presentation/widgets/reply_to_tweet_textfield.dart';

class TweetMediaDetails extends StatelessWidget {
  const TweetMediaDetails(this.tweet, this.pageViewIndex, {super.key});
  final tweet;
  final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  TweetAuthorAvatar(
                      tweet.author["avatar"], tweet.author["url"]),
                  TweetAuthorUsername(tweet.author["username"]),
                ],
              ),
            ),
            Flexible(
              child: PageView(
                controller: PageController(initialPage: pageViewIndex),
                physics: const BouncingScrollPhysics(),
                children: (tweet.media as List)
                  .map((media) => Container(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(context).size.height *
                                0.45,
                        minWidth: double
                            .infinity //MediaQuery.of(context).size.width,
                        ),
                      child: Hero(
                        tag: media["file"],
                        child: MediaFromNetwork(
                          media,
                          videoCanBePlayed: true,
                        ))),
                  ))
                  .toList())),
            BlocBuilder<TweetDetailsBloc, TweetDetailsState>(
              builder: (context, state) {
                if (state is TweetDetailsLoaded) {
                  final tweet = state.tweet;
                  return BlocListener<TweetRetweetCubit, TweetRetweetState>(
                    listener: (context, state) {
                      if (state is TweetRetweeted) {
                        
                        if (tweet.id == state.id) {
                          tweet.interactions++;
                          tweet.is_retweeted = true;
                        }
                      } else if (state is TweetUnretweeted) {
                        
                        if (tweet.id == state.id) {
                          tweet.interactions--;
                          tweet.is_retweeted = false;
                        }
                      }
                    },
                    child: BlocListener<TweetLikedBloc, TweetState>(
                      listener: (context, state) {
                        if(state is TweetLikedState) {
                          if(tweet.id == state.id) {
                            print("object");
                            tweet.likes++;
                            tweet.is_liked = true;
                          }
                        } else if(state is TweetUnlikedState) {
                          if(tweet.id == state.id) {
                            print("object2");
                            tweet.likes--;
                            tweet.is_liked = false;
                          }
                        }
                      },
                      child: TweetMenu(tweet),
                    )
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<TweetDetailsBloc, TweetDetailsState>(
              builder: (context, state) {
                if (state is TweetDetailsLoaded) {
                  return ReplyToTweet(null, state.tweet.id);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
    );
  }
}
