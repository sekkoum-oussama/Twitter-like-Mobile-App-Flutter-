import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/tweet/presentation/widgets/custom_confirmation_dialog.dart';
import 'package:twitter_demo/utils/current_user_service.dart';


showTweetOptions(BuildContext context, tweet) {
  final currentUser = GetIt.I.get<CurrentUserService>().user;

  showModalBottomSheet(
    context: context, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30)
      )
    ),
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: currentUser.id == tweet.author!["id"] ? SameUserTweetOptions(tweet) : const SizedBox(),
          )
          
        ],
      );
    }
  );
}


class SameUserTweetOptions extends StatelessWidget {
  SameUserTweetOptions(this.tweet, {super.key});
  final tweet;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeleteTweetButton(tweet.url)
      ],
    );
  }
}

class DeleteTweetButton extends StatefulWidget {
  DeleteTweetButton(this.tweetUrl, {super.key});
  final tweetUrl;

  @override
  State<DeleteTweetButton> createState() => _DeleteTweetButtonState();
}

class _DeleteTweetButtonState extends State<DeleteTweetButton> {

  onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  onDeleteTweet(BuildContext context) async {
    context.read<DeleteTweetCubit>().deleteTweet(widget.tweetUrl);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
        showConfirmationDialog(
          context, 
          "Delete post ?", 
          "This can't be undone and it will be removed from your profile, the timeline of any accounts that follow you, andfrom search results.", 
          "Cancel", 
          "Delete", 
          onCancel, 
          onDeleteTweet
        );
      }, 
      icon: const Icon(Icons.delete_outlined), 
      label: const Text("Delete Post"),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.bodyLarge!.color)
      ),
    );
  }
}