import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';

class ReplyToTweetAppBar extends StatelessWidget implements PreferredSizeWidget {
  ReplyToTweetAppBar(this.related_tweet, this._replyTextController, {super.key});
  final related_tweet;
  TextEditingController _replyTextController;
  bool isReplyButtonClickable = false;

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
              isReplyButtonClickable = state.isTextFilled! || state.isMediaselected!;
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: isReplyButtonClickable ? () {
                  try {
                    context.read<AddReplyBloc>();
                    print("I read the bloc normally");
                    final id = related_tweet.id;
                    final text = _replyTextController.text;
                    final files = context.read<MediaPickerCubit>().state;
                    print("variables are ready");
                    context.read<AddReplyBloc>().add(AddReply(id, text: text, files: files));
                  } catch(e) {
            
                    print("$e");
                  }                 
                } : null,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isReplyButtonClickable
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
                  "Reply",
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
