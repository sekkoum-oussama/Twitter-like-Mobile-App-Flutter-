import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweets_list_bloc/tweets_bloc.dart';

class TweetsListEmpty extends StatelessWidget {
  TweetsListEmpty({this.username, super.key});
  String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "No tweets to load, try later...",
            softWrap: true,
            style: TextStyle(
                fontSize: 19.0, fontWeight: FontWeight.w500, height: 1.5),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<TweetsListBloc>().add(GetTweets(username: username)),
            child: const Text("Load tweets"),
          )
        ],
      ),
    );
  }
}
