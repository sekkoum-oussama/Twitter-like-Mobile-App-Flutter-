import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:twitter_demo/register/business_logic/register_bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  final registerFormKey = GlobalKey<FormBuilderState>();
  final password1FieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is UnknownRegisterErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Something went wrong, Please try later")));
        } else if (state is RegisterErrorState) {
          state.errors!.forEach((field, error) {
            registerFormKey.currentState!
                .invalidateField(name: field, errorText: error[0]);
          });
        } else if (state is RegisteredState) {
          Navigator.of(context).pushNamed(
                                "/confirmEmail", 
                                arguments: registerFormKey.currentState!.fields["email"]!.value
          );
        }
      },
      child: FormBuilder(
        key: registerFormKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: "username",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(50),
                  FormBuilderValidators.minLength(5)
                ],
              ),
              decoration: const InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(fontSize: 14)
              ),
            ),
            FormBuilderTextField(
              name: "email",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
              ),
              decoration: const InputDecoration(
                labelText: "Email address",
                labelStyle: TextStyle(fontSize: 14)
              ),
            ),
            FormBuilderTextField(
              key: password1FieldKey,
              name: "password1",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(20),
                  FormBuilderValidators.minLength(8)
                ],
              ),
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 14)
              ),
            ),
            FormBuilderTextField(
              name: "password2",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(20),
                  FormBuilderValidators.minLength(8),
                  (password2) {
                    String password1 = password1FieldKey.currentState!.value;
                    if (password2 != password1) {
                      return "No match";
                    }
                    return null;
                  }
                ],
              ),
              decoration: const InputDecoration(
                labelText: "Confirm password",
                labelStyle: TextStyle(fontSize: 14)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is RegisterLoading ? null : () => registeruser(context, registerFormKey),
                    style: ButtonStyle(
                          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30)),
                          elevation: const MaterialStatePropertyAll<double>(0),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                            )
                          )
                        ),
                    child: const Text('create', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  registeruser(context, registerFormKey) {
    if (registerFormKey.currentState!.validate()) {
      BlocProvider.of<RegisterBloc>(context).add(Register(
        username: registerFormKey.currentState!.fields['username']!.value,
        email: registerFormKey.currentState!.fields['email']!.value,
        password1: registerFormKey.currentState!.fields['password1']!.value,
        password2: registerFormKey.currentState!.fields['password2']!.value,
      ));
    }
  }
}
