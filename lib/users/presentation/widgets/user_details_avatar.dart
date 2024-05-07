import 'package:flutter/material.dart';


class UserDetailsAvatar extends StatelessWidget {
  UserDetailsAvatar(this.avatar, {super.key});
  String avatar;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      bottom: -35,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          border: Border.all(width: 3, color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black)
        ),
        child: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(this.avatar),
        ),
      ), 
    );
  }
}