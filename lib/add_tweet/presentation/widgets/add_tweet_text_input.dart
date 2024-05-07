import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/utils/current_user_service.dart';


class AddTweetTextInput extends StatefulWidget {
  AddTweetTextInput(this.textController, {super.key});
  final textController;

  @override
  State<AddTweetTextInput> createState() => AddTweetTextInputState();
}

class AddTweetTextInputState extends State<AddTweetTextInput> {
  String? userPic;

  @override
  void initState() {
    super.initState();
    userPic = GetIt.I<CurrentUserService>().user.avatar;
  }


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userPic != null ? CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(userPic!),
              ) : const SizedBox(height: 32, width: 32,),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: widget.textController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: "What's happening"),
                  onChanged: (text) {
                    BlocProvider.of<ReplyInputCubit>(context).replyInputChanged(text);
                  },
                  maxLines: null,
                ),
              )
            ],
          )
      ),
    );
  }
}