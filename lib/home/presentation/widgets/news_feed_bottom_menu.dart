import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class NewsFeedBottomMenu extends StatefulWidget {
  const NewsFeedBottomMenu(this._showBottomMenu, {super.key});
  final bool? _showBottomMenu;

  @override
  State<NewsFeedBottomMenu> createState() => _NewsFeedBottomMenuState();
}

class _NewsFeedBottomMenuState extends State<NewsFeedBottomMenu> {
  


  @override
  void initState() {
    super.initState();
    
  }

    

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      height: widget._showBottomMenu! ? kBottomNavigationBarHeight : 0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color.fromARGB(255, 205, 200, 200), width: 0.7))
      ),
      child: Wrap(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 26,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "search"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "account"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: "notifications"),
              BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "messages"),
            ],
          ),
        ],
      )
    );
  }
}