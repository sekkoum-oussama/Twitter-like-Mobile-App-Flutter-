import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/update_user_appdar.dart';
import 'package:twitter_demo/users/presentation/widgets/update_user_fields.dart';
import 'package:twitter_demo/utils/current_user_service.dart';

class UserUpdateScreen extends StatefulWidget {
  const UserUpdateScreen({super.key});

  @override
  State<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  UserModel? currentUser;
  final _updateFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    currentUser = GetIt.I<CurrentUserService>().user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserCubit, UpdateUserState>(
        listener: (context, state) {
          if(state is UpdateUserSuccessState) {
            Navigator.of(context).pop(true);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: currentUser != null ?
               CustomScrollView(
                  slivers: [
                    UserUpdateAppBar(_updateFormKey),
                    UserUpdateFields(_updateFormKey)
                  ],
                )
            : const SizedBox(),
          )
        ),
      
    );
  }
}
