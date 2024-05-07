import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/retweets_list_cubit/retweet_list_cubit.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_details_error_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_notfound_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_retweets_listing_users.dart';


class RetweetsListScreen extends StatelessWidget {
  const RetweetsListScreen(this.id, {super.key});
  final int id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => RetweetsListCubit()..getRetweetsList(id),
          child: BlocBuilder<RetweetsListCubit, RetweetsListState>(
            builder: (context, state) {
              if(state is TweetNotFoundState) {
                return const TweetDetailsNotFoundWidget();
              } else if(state is RetweetsListError) {
                return const TweetDetailsErrorWidget();
              } else if(state is RetweetsListLoaded) {
                return TweetRetweetsUsersList(state.users);
              } else {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            }
          ),
        ),
      ),
    );
  }
}