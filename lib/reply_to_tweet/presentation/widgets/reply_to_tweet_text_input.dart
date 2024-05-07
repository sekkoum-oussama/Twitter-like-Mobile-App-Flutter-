import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/utils/current_user_service.dart';
import 'package:twitter_demo/utils/load_user_profile_pic.dart';


class ReplyTotweetTextInput extends StatefulWidget {
  ReplyTotweetTextInput(this.username, this.textController, {super.key});
  final username;
  final textController;

  @override
  State<ReplyTotweetTextInput> createState() => _ReplyTotweetTextInputState();
}

class _ReplyTotweetTextInputState extends State<ReplyTotweetTextInput> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 42),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "Replying to "),
                    TextSpan(text: "${widget.username}", style: const TextStyle(color: Colors.blue))
                  ]
                ),
                style: const TextStyle(
                  color: Color.fromARGB(255, 96, 93, 93),
                  fontSize: 14
                ),
              )
            ),
            Row(
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
                    onChanged: (text) => BlocProvider.of<ReplyInputCubit>(context).replyInputChanged(text),
                    maxLines: null,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}