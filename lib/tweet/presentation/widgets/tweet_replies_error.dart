import 'package:flutter/material.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_replies_bloc/tweet_replies_bloc.dart';


class TweetLoadingRepliesErrorWidget extends StatelessWidget {
  TweetLoadingRepliesErrorWidget(this.bloc, this.id, {super.key});
  TweetRepliesBloc bloc;
  int id;
  
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500, height: 1.5, color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ooooops!!'),
              const Text('An error occured while loading tweets...'),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed:() => bloc.add(GetTweetReplies(id)),
                child: const Text("Try again"),
              )
            ],
          ),
        ),
      ),
    );
  }
}