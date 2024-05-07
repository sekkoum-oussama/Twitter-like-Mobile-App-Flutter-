import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/follow_or_edit_profile_widget.dart';

class UserDetailsSliverContainerWidget extends StatefulWidget {
  UserDetailsSliverContainerWidget(this.user, {super.key});
  UserModel user;

  @override
  State<UserDetailsSliverContainerWidget> createState() =>
      _UserDetailsSliverContainerWidgetState();
}


class _UserDetailsSliverContainerWidgetState extends State<UserDetailsSliverContainerWidget> {
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if(state is UpdateUserSuccessState) {
          widget.user = state.user;
        }
      },
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildFollowOrEditProfileButton(widget.user),
                UserDetailsUserName(widget.user.username),
                UserDetailsBio(widget.user.bio),
                UserDetailsLocation(widget.user.location),
                UserDetailsDateOfBirth(widget.user.date_birth),
                UserDetailsDateJoined(widget.user.date_joined),
                UserDetailsFollows(widget.user),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserDetailsFollows extends StatelessWidget {
  const UserDetailsFollows(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          UserDetailsFollowing(user),
          const SizedBox(
            width: 15,
          ),
          UserDetailsFollowers(user),
        ],
      ),
    );
  }
}

class UserDetailsFollowing extends StatelessWidget {
  const UserDetailsFollowing(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/userFollowers',
          arguments: {"lookingFor": 'Following', 'username': user.username}),
      child: Row(
        children: [
          Text(
            "${user.following}",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Text(
            " Following",
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class UserDetailsFollowers extends StatelessWidget {
  const UserDetailsFollowers(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/userFollowers',
          arguments: {"lookingFor": 'Followers', 'username': user.username}),
      child: Row(
        children: [
          Text(
            "${user.followers}",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Text(" Followers",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ))
        ],
      ),
    );
  }
}

class UserDetailsDateJoined extends StatelessWidget {
  const UserDetailsDateJoined(this.date_joined, {super.key});
  final String? date_joined;

  @override
  Widget build(BuildContext context) {
    return date_joined == null
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey[600],
                  size: 16,
                ),
                Text(
                  " Joined $date_joined",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                )
              ],
            ),
          );
  }
}

class UserDetailsDateOfBirth extends StatelessWidget {
  UserDetailsDateOfBirth(this.date_birth, {super.key});
  String? date_birth;

  @override
  Widget build(BuildContext context) {
    return date_birth == null
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey[600],
                  size: 16,
                ),
                Text(
                  " Date birth $date_birth",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                )
              ],
            ),
          );
  }
}

class UserDetailsLocation extends StatelessWidget {
  UserDetailsLocation(this.location, {super.key});
  String? location;

  @override
  Widget build(BuildContext context) {
    return location == null
        ? const SizedBox()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[600],
                  size: 16,
                ),
                Text(
                  " $location",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                )
              ],
            ),
          );
  }
}

class UserDetailsBio extends StatelessWidget {
  UserDetailsBio(this.bio, {super.key});
  String? bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: bio == null
          ? const SizedBox()
          : Text(
              bio!,
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
}

class UserDetailsUserName extends StatelessWidget {
  UserDetailsUserName(this.username, {super.key});
  String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        username,
        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
      ),
    );
  }
}
