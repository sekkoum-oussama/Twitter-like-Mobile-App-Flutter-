import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/updata_user_photo_service.dart';

class UserUpdateImageFields extends StatefulWidget {
  UserUpdateImageFields({super.key});

  @override
  State<UserUpdateImageFields> createState() => _UserUpdateImageFieldsState();
}

class _UserUpdateImageFieldsState extends State<UserUpdateImageFields> {
  bool? canPickImage;
  bool? isCoverImagePciked;
  bool? isAvatarImagePicked;
  
  @override
  void initState() {
    super.initState();
    UpdateUserPhotoSManager.resetImages();
    canPickImage = true;
    isCoverImagePciked = false;
    isAvatarImagePicked = false;
  }

  void pickCoverImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      UpdateUserPhotoSManager.setCoverImage(image);
      setState(() {
        isCoverImagePciked = true;
      });
    }
  }

  void pickAvatarImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null) {
      UpdateUserPhotoSManager.setAvatarImage(image);
      setState(() {
        isAvatarImagePicked = true;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if(state is UpdateUserLoadingState) {
          canPickImage = false;
        }
      },
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.none,
          height: 140,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              isCoverImagePciked! ?
              Image.file(
                File(UpdateUserPhotoSManager.coverImage!.path),
                width: double.infinity,
                fit: BoxFit.cover,
              )
              : CachedNetworkImage(
                imageUrl: GetIt.I<CurrentUserService>().user.cover,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Center(
                    child: IconButton(
                      onPressed: canPickImage! ? () => pickCoverImage() : null,
                      icon: const Icon(Icons.camera_alt_outlined,size: 38,color: Colors.white,)
                    )
                  )
                ),
              Positioned(
                left: 12,
                bottom: -35,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black)),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: isAvatarImagePicked! ?
                        FileImage(File(UpdateUserPhotoSManager.avatarImage!.path))
                        :
                        CachedNetworkImageProvider(
                            GetIt.I<CurrentUserService>().user.avatar) as ImageProvider,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: IconButton(
                            onPressed: canPickImage! ? () => pickAvatarImage() : null,
                            icon: const Icon( Icons.camera_alt_outlined,size: 38,color: Colors.white,)
                          )
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
