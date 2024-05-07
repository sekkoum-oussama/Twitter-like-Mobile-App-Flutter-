import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:twitter_demo/password_reset/business_logic/password_rest_cubit/password_reset_cubit.dart';

class PasswordResetForm extends StatelessWidget {
  PasswordResetForm({super.key});

  final passwordResetFormKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetCubit(),
      child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
        listener: (context, state) {
          if (state is PasswordResetError) {
            passwordResetFormKey.currentState!
                .invalidateField(name: "email", errorText: state.error);
          } else if (state is PasswordresetUnknownError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong, please try again")));
          } else if (state is PasswordResetSuccess) {
            Navigator.of(context)
                .pushNamed('/passwordResetConfirm', arguments: state.email);
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 30),
            child: FormBuilder(
              key: passwordResetFormKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                  ),
                  const SizedBox(height: 15,),
                  BlocBuilder<PasswordResetCubit, PasswordResetState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state is PasswordResetLoading ? null : () => password_reset(context, passwordResetFormKey),  
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 35)),
                            elevation: const MaterialStatePropertyAll<double>(0),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)
                              )
                            )
                          ),
                          child: const Text("Send", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  password_reset(context, passwordResetFormKey) {
    if (passwordResetFormKey.currentState!.validate()) {
      BlocProvider.of<PasswordResetCubit>(context).password_reset(
          passwordResetFormKey.currentState!.fields['email']!.value);
    }
  }
}
