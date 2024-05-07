import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/tweets_list_bloc/tweets_bloc.dart';

class TweetsListError extends StatelessWidget {
  TweetsListError({this.username, super.key});
  String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ooooops!!\nAn error occured while loading tweets...',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, height: 1.5),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed:() => context.read<TweetsListBloc>().add(GetTweets(username: username)),
              child: const Text("Try again", style: TextStyle(fontSize: 17, color: Colors.white),),
            )
          ],
        
      ),
    );
  }

}
