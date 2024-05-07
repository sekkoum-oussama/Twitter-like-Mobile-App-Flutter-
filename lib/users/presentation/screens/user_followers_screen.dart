import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/users/business_logic/user_bloc/user_bloc.dart';
import 'package:twitter_demo/users/business_logic/user_followers_bloc/user_followers_bloc.dart';
import 'package:twitter_demo/users/presentation/widgets/follow_or_edit_profile_widget.dart';

class UserFollowerScreen extends StatefulWidget {
  UserFollowerScreen(this.lookingFor, this.username, {super.key});
  String lookingFor;
  String username;
  @override
  State<UserFollowerScreen> createState() => UserFollowerScreenState();
}

class UserFollowerScreenState extends State<UserFollowerScreen> {
  UserFollowersBloc _userFollowerBloc = UserFollowersBloc();

  @override
  void initState() {
    if (widget.lookingFor == 'Following') {
      _userFollowerBloc.add(UserGetFollowingsEvent(widget.username));
    } else {
      _userFollowerBloc.add(UserGetFollowersEvent(widget.username));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UserFollowersBloc, UserFollowersState>(
          bloc: _userFollowerBloc,
          builder: (context, state) {
            if (state is UserNotFound) {
              return const UserFollowersUserNotFoundWidget();
            } else if (state is UserFollowersError) {
              return const UserFollowersUnknownError();
            } else if (state is UserFollowersLoaded) {
              return UserFollowersListWidget("Followers", state.users);
            } else if(state is UserFollowingsLoaded) {
              return UserFollowersListWidget("Followers", state.users);
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}

class UserFollowersListWidget extends StatelessWidget {
  UserFollowersListWidget(this.title, this.users, {super.key});
  String title;
  List users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
        ),
        users.isEmpty ?
        UserFollowersEmpty()
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
    ));
  }
}

class UserFollowersEmpty extends StatelessWidget {
  const UserFollowersEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
        child: Text("Sorry, there are no users here!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
      ),
    );
  }
}

class UserFollowersInfo extends StatelessWidget {
  UserFollowersInfo(this.user, {super.key});
  Map user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/userDetails", arguments: user['url']),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user["avatar"]),
              radius: 20,
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user["username"],
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      BlocProvider(
                        create: (context) => UserBloc(),
                        child: FollowUnfollowButton(
                            user['username'], user['is_following']),
                      ),
                    ],
                  ),
                  user["bio"] == null ? const SizedBox() : Container(margin: EdgeInsets.only(top: 7), child: Text(user['bio'])),
                ]))
          ],
        ),
      ),
    );
  }
}

class UserFollowersUserNotFoundWidget extends StatelessWidget {
  const UserFollowersUserNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Text(
          "Sorry, this account doesn't exist anymore",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class UserFollowersUnknownError extends StatelessWidget {
  const UserFollowersUnknownError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Text(
          "Sorry, it seems we have an error, please try later",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
