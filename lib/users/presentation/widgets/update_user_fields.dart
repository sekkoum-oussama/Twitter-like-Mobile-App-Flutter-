import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/user_update_image_fields.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/text_input_formatters.dart';

class UserUpdateFields extends StatefulWidget {
  UserUpdateFields(this._updateFormKey, {super.key});
  final _updateFormKey;
  @override
  State<UserUpdateFields> createState() => _UserUpdateFieldsState();
}

class _UserUpdateFieldsState extends State<UserUpdateFields> {
  UserModel? user;
  bool? enabled;
  @override
  void initState() {
    super.initState();
    enabled = true;
    user = GetIt.I<CurrentUserService>().user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        enabled = true;
        if(state is UpdateUserLoadingState) {
          enabled = false;
        }
        if(state is UpdateUserErrorState) {
          state.errors.forEach((fieldName, errorMsg) { 
            widget._updateFormKey.currentState.fields[fieldName].invalidate(errorMsg[0]);
           });
        }
      },
      builder: (context, state) {
        return FormBuilder(
          key: widget._updateFormKey,
          child: SliverList.list(children: [
            UserUpdateImageFields(),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Name"),
                  FormBuilderTextField(
                    name: "username",
                    enabled: enabled!,
                    initialValue: user!.username,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(100)
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Bio"),
                  FormBuilderTextField(
                    name: "bio",
                    enabled: enabled!,
                    initialValue: user!.bio,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.maxLength(100)]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Location"),
                  FormBuilderTextField(
                    name: "location",
                    enabled: enabled!,
                    initialValue: user!.location,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.maxLength(100),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Date birth"),
                  FormBuilderTextField(
                    maxLines: 1,
                    name: "date_birth",
                    enabled: enabled!,
                    initialValue: user!.date_birth,
                    decoration: const InputDecoration(hintText: "YYYY-MM-DD", errorMaxLines: 3),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                      DateInputFormatter(sample: "YYYY-MM-DD", separator: "-"),
                    ],
                    validator: FormBuilderValidators.compose([
                        FormBuilderValidators.maxLength(100)
                      ]
                    ),
                  ),
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
