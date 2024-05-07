import 'package:flutter/material.dart';

class TweetAuthorAvatar extends StatelessWidget {
  TweetAuthorAvatar(this.avatarUrl, this.userUrl, {super.key});
  String avatarUrl;
  String userUrl; 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/userDetails", arguments:userUrl),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 12, 0),
        child: CircleAvatar(  
          radius: 20,
          backgroundImage: NetworkImage(avatarUrl),
        ),
      ),
    );
  }
}
