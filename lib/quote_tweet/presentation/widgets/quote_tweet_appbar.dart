
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/quote_tweet/business_logic/cubit/quote_tweet_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';


class QuoteTweetAppBar extends StatelessWidget implements PreferredSizeWidget {
  QuoteTweetAppBar(this.related_tweet, this._textController, {super.key});
  final related_tweet;
  TextEditingController _textController;
  bool isQuoteButtonClickable = false;

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
              isQuoteButtonClickable = state.isTextFilled! || state.isMediaselected!;
              
            },
            builder: (context, state) {
              QuoteTweetState quoteTweetState = context.watch<QuoteTweetCubit>().state;
              if(quoteTweetState is QuoteTweetLoading) {
                isQuoteButtonClickable = false;
              }
              return ElevatedButton(
                onPressed: isQuoteButtonClickable ? () {
                  context.read<QuoteTweetCubit>().quoteTweet(related_tweet.id, text: _textController.text, files: context.read<MediaPickerCubit>().state);
                  
                } : null,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isQuoteButtonClickable
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
                  "Repost",
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