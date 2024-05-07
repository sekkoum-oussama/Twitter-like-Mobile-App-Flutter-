import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:twitter_demo/home/business_logic/theme_cubit/theme_mode_cubit.dart';
import 'package:twitter_demo/home/business_logic/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_demo/themes/dark_theme.dart';
import 'package:twitter_demo/themes/light_theme.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/business_logic/delete_tweet_cubit/delete_tweet_cubit.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_retweet_cubit/tweet_retweet_cubit.dart';
import 'package:twitter_demo/utils/route_generator.dart';

class TwitterApp extends StatelessWidget {
  const TwitterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TweetLikedBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider(
          create: (context) => TweetRetweetCubit()
        ),
        BlocProvider(
          create: (context) => DeleteTweetCubit()
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeModeInfo>(
        builder: (context, themeMode) {
          return MaterialApp(
            theme: customLightTheme,
            darkTheme: customDarkTheme,
            themeMode: themeMode.mode,
            debugShowCheckedModeBanner: false,
            title: 'Sekkoum twitter',
            onGenerateRoute: MyRouter.onGenereteRoute,
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}