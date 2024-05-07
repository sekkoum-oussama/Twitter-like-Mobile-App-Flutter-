import 'package:flutter/material.dart';
import 'package:twitter_demo/password_reset/representation/widgets/password_reset_confirm_form.dart';

class PasswordResetConfirmScreen extends StatelessWidget {
  PasswordResetConfirmScreen(this.email, {super.key});

  var email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              children: [
                Text(
                  'A confirmation code has been sent to $email, copy and past it below',
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                ),
                PasswordResetConfirmForm(email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
