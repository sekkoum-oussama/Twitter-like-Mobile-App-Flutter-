import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/add_tweet/business_logic/add_tweet_cubit/add_tweet_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';

class AddTweetAppBar extends StatelessWidget implements PreferredSizeWidget {
  AddTweetAppBar(this._textController, {super.key});
  TextEditingController _textController;
  bool isPostButtonClickable = false;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.close),
      ),
      elevation: 0.5,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: BlocConsumer<ReplyInputCubit, ReplyInputState>(
            listener: (context, state) {
              isPostButtonClickable = state.isTextFilled! || state.isMediaselected!;
            },
            builder: (context, replyInputState) {
              final addTweetState = context.watch<AddTweetCubit>().state;
              if(addTweetState is AddTweetLoading) {
                isPostButtonClickable = false;
              } else if(addTweetState is AddTweetError || addTweetState is AddTweetUnknownError) {
                isPostButtonClickable = replyInputState.isTextFilled! || replyInputState.isMediaselected!;
              }
              return ElevatedButton(
                onPressed: isPostButtonClickable ? () {
                  context.read<AddTweetCubit>().addTweet(text: _textController.text, files: context.read<MediaPickerCubit>().state);
                } : null,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isPostButtonClickable
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.6)
                    ),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 14, vertical: 2)),
                    elevation: const MaterialStatePropertyAll<double>(0),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)))),
                child: const Text(
                  "Post",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
