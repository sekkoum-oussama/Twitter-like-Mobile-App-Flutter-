import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/users/business_logic/user_screen_bloc/user_screen_bloc.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_error_widget.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_widget.dart';

class UserDetailsCreen extends StatefulWidget {
  UserDetailsCreen(this.userUrl, {super.key});
  var userUrl;

  @override
  State<UserDetailsCreen> createState() => _UserDetailsCreenState();
}

class _UserDetailsCreenState extends State<UserDetailsCreen> {
  final _userScreenBloc = UserScreenBloc();

  @override
  void initState() {
    _userScreenBloc.add(GetUserDetailsEvent(widget.userUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserScreenBloc, UserScreenState>(
        bloc: _userScreenBloc,
        listener: (context, state) => {},
        builder: (context, state) {
          if (state is UserDetailsError) {
            return const UserDetailsErrorWidget();
          } else if (state is UserDetailsLoaded) {
            return UserDetailsWidget(state.user);
          } else {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
    ));
  }
}
