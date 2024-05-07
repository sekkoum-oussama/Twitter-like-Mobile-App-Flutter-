import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:twitter_demo/password_reset/business_logic/password_reset_confirm_cubit/password_reset_confirm_cubit.dart';

class PasswordResetConfirmForm extends StatelessWidget {
  PasswordResetConfirmForm(this.email, {super.key});
  String? email;

  final passwordResetConfirmFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetConfirmCubit(),
      child: BlocConsumer<PasswordResetConfirmCubit, PasswordResetConfirmState>(
        listener: (context, state) {
          if(state is PasswordResetConfirmUnknownError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Something went wrong, please try again"))
            );
          } else if(state is PasswordResetConfirmError) {
            state.errors.forEach((key, value) { 
              passwordResetConfirmFormKey.currentState!.invalidateField(
                name: key,
                errorText: value[0] 
              );
             },
            );
          } else if(state is PasswordResetConfirmSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("You have successfully changed your password"))
            );
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          } 
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 25),
            child: FormBuilder(
              key: passwordResetConfirmFormKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'token',
                    validator: FormBuilderValidators.required(),
                    decoration:
                        const InputDecoration(labelText: 'Confirmation code'),
                  ),
                  const SizedBox(height: 20,),
                  FormBuilderTextField(
                    name: 'new_password1',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                      ],
                    ),
                    decoration:
                        const InputDecoration(labelText: 'New password'),
                  ),
                  const SizedBox(height: 20,),
                  FormBuilderTextField(
                    name: 'new_password2',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                        (new_password2) {
                          final new_password1 = passwordResetConfirmFormKey
                              .currentState!.fields['new_password1']!.value;
                          if (new_password2 != new_password1) {
                            return 'Make sure the two passwords are equal';
                          }
                          return null;
                        }
                      ],
                    ),
                    decoration:
                        const InputDecoration(labelText: 'Confirm password'),
                  ),
                  const SizedBox(height: 20,),
                  BlocBuilder<PasswordResetConfirmCubit,
                      PasswordResetConfirmState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is PasswordResetConfirmLoading ? null : () => password_reset_confirm(context, passwordResetConfirmFormKey),
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30)),
                          elevation: const MaterialStatePropertyAll<double>(0),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                            )
                          )
                        ),
                        child: const Text('Reset password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  password_reset_confirm(context, passwordResetConfirmFormKey) {
    if (passwordResetConfirmFormKey.currentState!.validate()) {
      BlocProvider.of<PasswordResetConfirmCubit>(context)
          .password_reset_confirm(
        email,
        passwordResetConfirmFormKey.currentState!.fields['token']!.value,
        passwordResetConfirmFormKey
            .currentState!.fields['new_password1']!.value,
        passwordResetConfirmFormKey
            .currentState!.fields['new_password2']!.value,
      );
    }
  }
}
