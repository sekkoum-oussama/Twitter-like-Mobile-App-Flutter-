import 'package:flutter/material.dart';
import 'package:twitter_demo/tweet/presentation/widgets/retweets_list_empty.dart';
import 'package:twitter_demo/users/presentation/screens/user_followers_screen.dart';


class TweetRetweetsUsersList extends StatelessWidget {
  const TweetRetweetsUsersList(this.users, {super.key});
  final List users;
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            "Reposted by",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
        ),
        users.isEmpty ?
        const RetweetsListEmpty()
        :
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return UserFollowersInfo(users[index]);
            }, 
            childCount: users.length
          ),
        )
      ],
    );
  }
}