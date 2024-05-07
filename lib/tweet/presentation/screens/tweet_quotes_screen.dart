import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/quotes_list_cubit/quotes_list_cubit.dart';
import 'package:twitter_demo/tweet/presentation/widgets/quotes_list.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_details_error_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/tweet_notfound_widget.dart';


class QuotesListScreen extends StatelessWidget {
  const QuotesListScreen(this.id, {super.key});
  final id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => QuotesListCubit()..getTweetQuotes(id),
          child: BlocBuilder<QuotesListCubit, QuotesListState>(
            builder: (context, state) {
              if(state is TweetNotFoundState) {
                return const TweetDetailsNotFoundWidget();
              } else if(state is QuotesListErrorState) {
                return const TweetDetailsErrorWidget();
              } else if(state is QuotesListLoaded) {
                return QuotesListWidget(state.quotes);
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