import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:twitter_demo/login/business_logic/login_cubit/login_cubit.dart';
import 'package:twitter_demo/login/presentation/widgets/login_error_message.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final loginFormKey = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginUnknownError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong, please try later")));
          } else if (state is LoginSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
          }
        },
        child: FormBuilder(
          key: loginFormKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: "email",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "password",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(8),
                ]),
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 17)),
              ),
              SizedBox(
                height: 50.0,
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginError) {
                      String? errortext = state.error;
                      return LoginErrorMessage(errortext, loginFormKey.currentState!.fields["email"]!.value);
                    }
                    return Container();
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is LoginLoading ? null : () => login(context, loginFormKey),
                      style: ButtonStyle(
                        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 35)),
                        elevation: const MaterialStatePropertyAll<double>(0),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                          )
                        )
                      ),
                      child: const Text("Log in", style: TextStyle(fontSize: 17),),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  login(context, loginFormKey) {
    if (loginFormKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).login(
        loginFormKey.currentState!.fields["email"].value,
        loginFormKey.currentState!.fields["password"].value,
      );
    }
  }
}
