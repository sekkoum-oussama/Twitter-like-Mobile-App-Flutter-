import 'package:flutter/material.dart';

class UserDetailsErrorWidget extends StatelessWidget {
  const UserDetailsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This account doesn't exist anymore",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
