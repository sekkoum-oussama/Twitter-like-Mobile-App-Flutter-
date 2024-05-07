import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/business_logic/user_bloc/user_bloc.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_appbar_widget.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_sliver_container_widget.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_tweets_widget.dart';

class UserDetailsWidget extends StatelessWidget {
  UserDetailsWidget(this.user, {super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserCubit(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            UserDetailsAppBarSliverWidget(user),
            UserDetailsSliverContainerWidget(user),
            UserDetailsTweetsSliverWidget(user.username),
          ],
        ),
      ),
    );
  }
}
