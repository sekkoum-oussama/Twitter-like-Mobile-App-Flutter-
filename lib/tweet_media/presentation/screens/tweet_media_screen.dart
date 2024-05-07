import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_details_bloc/tweet_details_bloc.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_notfound_widget.dart';
import 'package:twitter_demo/tweet_media/presentation/widgets/tweet_media_details.dart';


class TweetMediaScren extends StatelessWidget {
  TweetMediaScren(this.tweet, this.pageViewIndex, {super.key});
  final tweet;
  final int pageViewIndex;
  bool isTweetDeleted = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddReplyBloc()
          ),
          BlocProvider(
            create: (context) => TweetDetailsBloc()..add(GetTweetDetails(tweet.url))
          )
        ],
        child: BlocListener<TweetDetailsBloc, TweetDetailsState>(
          listener: (context, state) {
            if(state is TweetNotFound) {
              isTweetDeleted = true;
            }
          },
          child: isTweetDeleted ? 
                const TweetDetailsNotFoundWidget() : 
                TweetMediaDetails(tweet, pageViewIndex)
        )
      ),
    ));
  }
}
