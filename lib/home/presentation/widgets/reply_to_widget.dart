import 'package:flutter/material.dart';


class ReplyToWidget extends StatelessWidget {
  ReplyToWidget(this.reply_to, {super.key});
  final String? reply_to;

  String reply_to_text(List<String>? users) {
    String msg;
    if(users!.length < 3) {
      msg = users.join(", ");
    } else {
      msg = users.getRange(0, 2).toList().join(", ");
      msg += " and ";
      msg += users.getRange(2, users.length).toList().length.toString();
      msg += " other(s)";
    }
    return msg;
  } 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'reply to ', style: TextStyle(fontSize: 13.5, color: Color.fromARGB(255, 96, 93, 93))),
            TextSpan(text: reply_to, style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 3, 123, 221)))
          ]
        )
      )
    );
  }
}