import 'package:flutter/material.dart';

class CreateAccountTitle extends StatelessWidget {
  const CreateAccountTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 70, 0, 25),
      child: const Text(
        "Create an account",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
  }
}
