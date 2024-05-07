import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_details_bloc/tweet_details_bloc.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_details_error_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_details_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_notfound_widget.dart';

class TweetScreen extends StatelessWidget {
  TweetScreen(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tweet",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) {
            return TweetDetailsBloc()..add(GetTweetDetails(tweet.url));
          },
          child: BlocBuilder<TweetDetailsBloc, TweetDetailsState>(
            builder: (context, state) {
              if(state is TweetNotFound) {
                return const TweetDetailsNotFoundWidget();
              } else if(state is TweetDetailsError) {
                return const TweetDetailsErrorWidget();
              } else if(state is TweetDetailsLoaded) {
                return TweetDetailsWidget(state.tweet);
              } else if(state is TweetDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
