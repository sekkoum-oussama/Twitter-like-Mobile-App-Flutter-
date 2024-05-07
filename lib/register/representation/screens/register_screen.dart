import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/register/business_logic/register_bloc/register_bloc.dart';
import 'package:twitter_demo/register/representation/widgets/create_account_title.dart';
import 'package:twitter_demo/register/representation/widgets/register_form.dart';
import 'package:twitter_demo/register/representation/widgets/logo_and_login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const LogoAndLogin(),
                  const CreateAccountTitle(),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
