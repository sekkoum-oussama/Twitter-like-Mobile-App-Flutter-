import 'package:flutter/material.dart';

class LogoAndLogin extends StatelessWidget {
  const LogoAndLogin({super.key});

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
            top: 7,
            child: TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false),
              child: const Text("Log In", style: TextStyle(fontSize: 17),),
            ),
          )
        ],
      ),
    );
  }
}
