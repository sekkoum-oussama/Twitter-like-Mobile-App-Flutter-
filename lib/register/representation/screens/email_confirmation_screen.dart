import 'package:flutter/material.dart';
import 'package:twitter_demo/register/representation/widgets/confirm_email_form.dart';
import 'package:twitter_demo/register/representation/widgets/confirm_email_sent_title.dart';


class EmailConfirmationScreen extends StatelessWidget {
  EmailConfirmationScreen(this.email, {Key? key}) : super(key: key);
  var email;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ConfirmationEmailSentTitle(email),
                ConfirmEmailForm(),
                TextButton(
                  onPressed: () {} , 
                  child: const Text("Send another confirmation code")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}