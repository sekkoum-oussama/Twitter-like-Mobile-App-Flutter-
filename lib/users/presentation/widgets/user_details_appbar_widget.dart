import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/data/models/user_model.dart';
import 'package:twitter_demo/users/presentation/widgets/user_details_avatar.dart';

class UserDetailsAppBarSliverWidget extends StatelessWidget {
  UserDetailsAppBarSliverWidget(this.user, {super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if(state is UpdateUserSuccessState) {
          user = state.user;
        }
      },
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
            clipBehavior: Clip.none,
            height: 140,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  user.cover,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                UserDetailsAvatar(user.avatar),
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withAlpha(160)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withAlpha(160)),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 48,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withAlpha(160)),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
