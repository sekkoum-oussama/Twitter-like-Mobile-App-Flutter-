import 'package:flutter/material.dart';
import 'package:twitter_demo/register/data/data_providers.dart';

class LoginErrorMessage extends StatelessWidget {
  LoginErrorMessage(this.errorText, this.email, {super.key});
  String? errorText;
  var email;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: const TextStyle(
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$errorText",
            ),
            errorText == "E-mail is not verified."
                ? TextButton(
                    child: const Text("verify here"),
                    onPressed: () async {
                      try {
                        await RegisterDataProvider.resend_email_verification(email);
                        Navigator.of(context).pushNamed("/confirmEmail", arguments: email);
                      } catch(e) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
                      }
                    },
                  )
                  : Container()
          ],
        ),
      
    );
  }
}
