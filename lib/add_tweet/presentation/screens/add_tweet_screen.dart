import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/add_tweet/business_logic/add_tweet_cubit/add_tweet_cubit.dart';
import 'package:twitter_demo/add_tweet/presentation/widgets/add_tweet_appbar.dart';
import 'package:twitter_demo/add_tweet/presentation/widgets/add_tweet_text_input.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/media_picker_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/original_tweet.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/reply_to_tweet_appBar.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/reply_to_tweet_text_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/selected_media.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/utils/custom_snackbar.dart';


class AddTweetScreen extends StatefulWidget {
  const AddTweetScreen({super.key});

  @override
  State<AddTweetScreen> createState() => _AddTweetScreenState();
}


class _AddTweetScreenState extends State<AddTweetScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MediaPickerCubit(),
        ),
        BlocProvider(
          create: (context) => ReplyInputCubit(context.read<MediaPickerCubit>()),
        ),
        BlocProvider(
          create: (context) => AddTweetCubit(),
        )
      ],
      child: BlocListener<AddTweetCubit, AddTweetState>(
        listener: (context, state) {
          if(state is TweetAddedState) {
            Navigator.of(context).pop(true);
          } else if(state is AddTweetError) {
            showCustomSnackBar(context, Text(state.errorMsg));
          } else if(state is AddTweetUnknownError) {
            showCustomSnackBar(context, const Text("Could not upload post, please try again..."));
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AddTweetAppBar(_textController),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        AddTweetTextInput(_textController,),
                        SelectedMedia(),
                      ],
                    ),
                  ),
                  MediaPickerInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
