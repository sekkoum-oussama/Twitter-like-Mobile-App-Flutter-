import 'package:flutter/material.dart';


class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 17, color: Theme.of(context).textTheme.bodyMedium!.color),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            const Text("Forget your password ?", style: TextStyle(fontWeight: FontWeight.w500),),
            TextButton(
              child: const Text("Click here"),
              onPressed: () {
                Navigator.of(context).pushNamed('/passwordReset');
              },
            )
          ],
        ),
        
      ),
    );
  }
}