import 'package:flutter/material.dart';
import 'package:twitter_demo/login/presentation/widgets/forget_password_button.dart';
import 'package:twitter_demo/login/presentation/widgets/login_form.dart';
import 'package:twitter_demo/login/presentation/widgets/logo_and_signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const LogoAndSignUp(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0,100,0,30),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Log in to Twitter",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                LoginForm(),
                const ForgetPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
