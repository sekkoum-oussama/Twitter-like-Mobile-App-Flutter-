import 'package:flutter/material.dart';

class ConfirmationEmailSentTitle extends StatelessWidget {
  ConfirmationEmailSentTitle(this.email, {super.key});
  String? email;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: "Confirmation code has been sent to ",
          style: const TextStyle(color: Colors.black, fontSize: 15),
          children: [
            TextSpan(text: "$email", style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: ", copy and past it below:")
          ]
        ),
      
    );
  }
}
