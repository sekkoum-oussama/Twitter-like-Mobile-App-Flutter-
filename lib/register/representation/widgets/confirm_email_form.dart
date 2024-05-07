import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:twitter_demo/register/business_logic/confirm_email_cubit/confirm_email_cubit.dart';

class ConfirmEmailForm extends StatelessWidget {
  ConfirmEmailForm({super.key});

  final emailConfirmFormKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmEmailCubit(),
      child: BlocListener<ConfirmEmailCubit, ConfirmEmailState>(
        listener: (context, state) async {
          if (state is ConfirmEmailError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    "Something went wrong, try later, or click on Send confirmation code")));
          } else if(state is ConfirmEmailWrongKeyError) {
            emailConfirmFormKey.currentState!.invalidateField(name: "confirmationcode", errorText: "Wrong key, please enter the key sent to your email address");
          }
          else if(state is ConfirmEmailSuccess) {
            emailConfirmFormKey.currentState!.invalidateField(name: "confirmationcode", errorText: "");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2), content: Text("User activated...")));
            await Future.delayed(
              const Duration(milliseconds: 500),
              () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false),
            );
            
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: FormBuilder(
            key: emailConfirmFormKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "confirmationcode",
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(errorText: "Past the confirmation code")]
                  ),
                  decoration: const InputDecoration(
                    labelText: "Confirmation code",
                    labelStyle: TextStyle(fontSize: 13)
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<ConfirmEmailCubit, ConfirmEmailState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is ConfirmEmailLoading ? null : () => confirm_email(context, emailConfirmFormKey),
                      child: const Text("Confirm Email"),
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 30)),
                          elevation: const MaterialStatePropertyAll<double>(0),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                            )
                          )
                        ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  confirm_email(context, emailConfirmFormKey) {
    if(emailConfirmFormKey.currentState!.validate()) {
      BlocProvider.of<ConfirmEmailCubit>(context).confirm_email(emailConfirmFormKey.currentState!.fields["confirmationcode"].value);
    }
  }
}
