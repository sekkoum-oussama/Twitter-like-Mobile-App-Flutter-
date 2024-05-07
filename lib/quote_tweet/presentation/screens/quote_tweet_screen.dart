import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quoted_tweet_widget.dart';
import 'package:twitter_demo/quote_tweet/business_logic/cubit/quote_tweet_cubit.dart';
import 'package:twitter_demo/quote_tweet/presentation/widgets/quote_tweet_appbar.dart';
import 'package:twitter_demo/quote_tweet/presentation/widgets/quote_tweet_text_input.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/media_picker_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/reply_to_tweet_text_input.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/selected_media.dart';

class QuoteTweetScreen extends StatelessWidget {
  QuoteTweetScreen(this.related_tweet, {super.key});

  final QuotedTweetModel related_tweet;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MediaPickerCubit()),
        BlocProvider( create: (context) => ReplyInputCubit(context.read<MediaPickerCubit>())),
        BlocProvider(create: (context) => QuoteTweetCubit())
      ],
      child: BlocListener<QuoteTweetCubit, QuoteTweetState>(
        listener: (context, state) {
          if(state is TweetQuoted) {
            Navigator.of(context).pop(true);
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: QuoteTweetAppBar(related_tweet, _textEditingController),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        QuoteTweetTextInput(
                          _textEditingController,
                        ),
                        SelectedMedia(),
                        SliverToBoxAdapter(
                            child: QuotedTweetWidget(related_tweet))
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
