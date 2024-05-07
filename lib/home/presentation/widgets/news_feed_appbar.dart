import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/load_user_profile_pic.dart';


class NewsFeedAppBar extends StatefulWidget {
  NewsFeedAppBar({super.key});
  
  @override
  State<NewsFeedAppBar> createState() => _NewsFeedAppBarState();
}

class _NewsFeedAppBarState extends State<NewsFeedAppBar> {
  String? userAvatar;

  @override
  void initState() {
    super.initState();
    userAvatar = GetIt.I<CurrentUserService>().user.avatar;
  }


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: IconButton(
        onPressed: () =>Scaffold.of(context).openDrawer(),
        icon: CircleAvatar(
          radius: 15,
          backgroundImage: userAvatar != null ? NetworkImage(userAvatar!) : null,
        ),
      ),
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2, color: Color.fromARGB(255, 205, 200, 200)))
        ),
      ),
    );
  }
}