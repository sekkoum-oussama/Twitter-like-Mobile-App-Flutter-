import 'package:flutter/material.dart';

class QuotedUserAvatar extends StatelessWidget {
  QuotedUserAvatar(this.avatarUrl, {super.key});
  String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: CircleAvatar(  
        radius: 9,
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }
}