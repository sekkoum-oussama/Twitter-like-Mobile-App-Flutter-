import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/business_logic/user_bloc/user_bloc.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/utils/current_user_service.dart';

class BuildFollowOrEditProfileButton extends StatelessWidget {
  const BuildFollowOrEditProfileButton(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GetIt.I<CurrentUserService>().user.id == user.id ? EditProfileButton() : FollowUnfollowButton(user.username, user.is_following)     
      ],
    );
  }
}


class FollowUnfollowButton extends StatelessWidget{
  FollowUnfollowButton(this.username, this.is_following, {super.key});
  String username;
  bool? is_following;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if(state is UserFollowError || state is UserUnfollowError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content:  Text("Sorry! error occured, please try later"))
              );
            } else if(state is UserFollowSuccess) {
              is_following = true;
            } else if(state is UserUnfollowSuccess) {
              is_following = false;
            }
          },
          builder: (context, state) {
            if(is_following == true) {
              return GestureDetector(
                onTap: () { BlocProvider.of<UserBloc>(context).add(UnfollowUserEvent(username)); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8,),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black, 
                    border: Border.all(color: Colors.grey) , 
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('Following', style: TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,)),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () { BlocProvider.of<UserBloc>(context).add(FollowUserEvent(username)); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8,),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white, 
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('Follow', style: TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,)),
                ),
              );
            }
          },
        ),
    );
    
  }
}


class EditProfileButton extends StatelessWidget{
  EditProfileButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6,),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!) , 
        borderRadius: BorderRadius.circular(30)
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed("/updateProfile", arguments: context.read<UpdateUserCubit>()),
        child: Text('Edit profile', style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,)),
      ),
    );
  }
}
