import 'package:flutter/material.dart';
import 'package:twitter_demo/password_reset/representation/widgets/password_reset_form.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 170),
            child: Column(
              children: [
                const Text(
                  "Forget your password ? Type your email address and click send :",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                ),
                PasswordResetForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
