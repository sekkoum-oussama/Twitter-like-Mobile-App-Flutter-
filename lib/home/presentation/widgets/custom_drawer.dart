import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/home/presentation/widgets/change_theme_mode.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_sliver_container_widget.dart';
import 'package:twitter_demo/utils/current_user_service.dart';


class HomeScreenDrawer extends StatefulWidget {
  HomeScreenDrawer({super.key});

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = GetIt.I<CurrentUserService>().user;
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: userModel != null ? Stack(
        children: [
          ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/userDetails", arguments: userModel!.url),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(userModel!.avatar),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/userDetails", arguments: userModel!.url),
                      child: Text(userModel!.username, style: const TextStyle(fontSize: 18),)
                    ),
                    const SizedBox(height: 15,),
                    UserDetailsFollows(userModel!)
                  ],
                )
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => Navigator.of(context).pushNamed("/userDetails", arguments: userModel!.url),
                iconColor: Theme.of(context).iconTheme.color,
                leading: const Icon(Icons.person_outline,),
                title: const Text("Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                iconColor: Theme.of(context).iconTheme.color,
                leading: const Icon(Icons.topic_outlined),
                title: const Text("Topics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                iconColor: Theme.of(context).iconTheme.color,
                leading: const Icon(Icons.bookmark_outline_outlined,),
                title: const Text("Booksmarks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                iconColor: Theme.of(context).iconTheme.color,
                leading: const Icon(Icons.list_alt_outlined,),
                title: const Text("Lists", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              ),
              const Divider(),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    title: const Text("Profissional Tools", style: TextStyle(fontSize: 15),),
                    children: [
                      ListTile(
                        iconColor: Theme.of(context).iconTheme.color,
                        leading: const Icon(Icons.rocket_launch_outlined, size: 18),
                        title: const Text("Twitter For Professionals", style: TextStyle(fontSize: 12.5),),
                      ),
                      ListTile(
                        iconColor: Theme.of(context).iconTheme.color,
                        leading: const Icon(Icons.monetization_on_outlined, size: 18),
                        title: const Text("Monetization", style: TextStyle(fontSize: 12.5),),
                      ),
                    ],
                  
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    title: const Text("Settings & Support", style: TextStyle(fontSize: 15),),
                    children: [
                      ListTile(
                        iconColor: Theme.of(context).iconTheme.color,
                        leading: const Icon(Icons.settings_outlined, size: 18),
                        title: const Text("Setting and privacy", style: TextStyle(fontSize: 12.5),),
                      ),
                      ListTile(
                        iconColor: Theme.of(context).iconTheme.color,
                        leading: const Icon(Icons.help_outline_outlined, size: 18),
                        title: const Text("Help Center", style: TextStyle(fontSize: 12.5),),
                      ),
                    ],
                  ),
              ),
              
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 10),
              child: IconButton(
                iconSize: 30,
                icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                  showModalBottomSheet(
                    context: context, 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                      )
                    ),
                    builder: (context) => const ChangeThemeMode()
                  );
                },
              ),
            ),
          )
        ],
      ) 
      : 
      const Center(child: Text("Loading...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),),
      ),
    );
  }


}