import 'package:flutter/material.dart';

class RetweetTextWidget extends StatelessWidget {
  RetweetTextWidget(this.author, {super.key});
  String? author;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.repeat,size: 17, color: Color.fromARGB(255, 104, 101, 101)),
          ),
          SizedBox(width: 7,),
          Text(
            "$author retweeted", 
            style: const TextStyle(color: Color.fromARGB(255, 104, 101, 101), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
