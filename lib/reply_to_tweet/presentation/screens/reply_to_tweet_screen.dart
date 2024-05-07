
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/media_picker_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/original_tweet.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/reply_to_tweet_appBar.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/reply_to_tweet_text_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/selected_media.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';

class ReplyToTweetScreen extends StatefulWidget {
  ReplyToTweetScreen(this.related_tweet, {super.key});
  final related_tweet;

  @override
  State<ReplyToTweetScreen> createState() => _ReplyToTweetScreenState();
}

class _ReplyToTweetScreenState extends State<ReplyToTweetScreen> {
  final TextEditingController _replyTextController = TextEditingController();
  final _centerKey = GlobalKey();
  bool isAddReplyBlocAvailable = false;

   @override
  void initState() {
    try {
      if(!context.read<AddReplyBloc>().isClosed) {
        isAddReplyBlocAvailable = true;
      }
    } catch(e) {}
    super.initState();
  }

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
        if(!isAddReplyBlocAvailable) BlocProvider(create: (context)=> AddReplyBloc())
      ],
      child: BlocListener<AddReplyBloc, AddReplyState>(
        listener: (context, state) {
          if(state is AddReplyLoaded) {
            Navigator.of(context).pop(true);
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: ReplyToTweetAppBar(widget.related_tweet, _replyTextController),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      center: _centerKey,
                      slivers: [
                        OriginalTweet(widget.related_tweet),
                        ReplyTotweetTextInput(widget.related_tweet.author!["username"], _replyTextController, key: _centerKey,),
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
