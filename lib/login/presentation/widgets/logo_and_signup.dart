import 'package:flutter/material.dart';

class LogoAndSignUp extends StatelessWidget {
  const LogoAndSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/twitter_logo.png",
              width: 26,
              height: 27,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 0,
            top: 5,
            child: TextButton(
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil("/register", (route) => false),
              child: const Text("Sign Up", style: TextStyle(fontSize: 16),),
            ),
          )
        ],
      ),
    );
  }
}
