import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/updata_user_photo_service.dart';

class UserUpdateAppBar extends StatefulWidget {
  const UserUpdateAppBar(this._updateFormKey, {super.key});
  final _updateFormKey;

  @override
  State<UserUpdateAppBar> createState() => _UserUpdateAppBarState();
}

class _UserUpdateAppBarState extends State<UserUpdateAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop(),),
      title: const Text("Edit profile"),
      actions: [
        TextButton(onPressed: validateUpdateForm, child: const Text("Save"))
      ],
    );
  }

  validateUpdateForm() {
    if(widget._updateFormKey.currentState!.validate()) {
      List<Map<String, dynamic>> files = []; 
      final cover =  UpdateUserPhotoSManager.coverImage;
      final avatar = UpdateUserPhotoSManager.avatarImage;
      if(cover != null) files.add({"fieldName" : "cover", "image" : File(cover.path)});
      if(avatar != null) files.add({"fieldName" : "avatar", "image" : File(avatar.path)});
      Map<String, String>? newValues = {}; 
      widget._updateFormKey.currentState.fields.forEach((key, value) => newValues[key.toString()] = value.value.toString());
      context.read<UpdateUserCubit>().updateUser(
        GetIt.I<CurrentUserService>().user.username, 
        newValues,
        files: files,
      );
    }

  }
}