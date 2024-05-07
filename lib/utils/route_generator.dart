import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_demo/add_tweet/presentation/screens/add_tweet_screen.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/presentation/screens/home_screen.dart';
import 'package:twitter_demo/login/presentation/screens/login_screen.dart';
import 'package:twitter_demo/password_reset/representation/screens/password_reset_confirm_screen.dart';
import 'package:twitter_demo/password_reset/representation/screens/password_reset_screen.dart';
import 'package:twitter_demo/quote_tweet/presentation/screens/quote_tweet_screen.dart';
import 'package:twitter_demo/register/representation/screens/email_confirmation_screen.dart';
import 'package:twitter_demo/register/representation/screens/register_screen.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/screens/reply_to_tweet_screen.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/screens/media_gallery_screen.dart';
import 'package:twitter_demo/take_photo/presentation/screens/take_picture_screen.dart';
import 'package:twitter_demo/tweet/business_logic/add_reply_bloc/add_reply_bloc.dart';
import 'package:twitter_demo/tweet/presentation/screens/tweet_details_screen.dart';
import 'package:twitter_demo/tweet/presentation/screens/tweet_quotes_screen.dart';
import 'package:twitter_demo/tweet/presentation/screens/tweet_retweets_screen.dart';
import 'package:twitter_demo/tweet_media/presentation/screens/tweet_media_screen.dart';
import 'package:twitter_demo/users/business_logic/update_user_cubit/update_user_cubit.dart';
import 'package:twitter_demo/users/presentation/screens/user_details_screen.dart';
import 'package:twitter_demo/users/presentation/screens/user_followers_screen.dart';
import 'package:twitter_demo/users/presentation/screens/user_update_screen.dart';
import 'package:twitter_demo/utils/check_user_credentials.dart';
import 'package:twitter_demo/utils/current_user_service.dart';


class MyRouter {
  static Route<dynamic> onGenereteRoute(RouteSettings settings) {
    String? name = settings.name;
    switch(name) {
      case '/updateProfile':
        return MyRouter.get_route_if_logged_in<UpdateUserCubit>(UserUpdateScreen(), settings.arguments as UpdateUserCubit);
      case '/tweetMedia':
        return MyRouter.get_route_if_logged_in(TweetMediaScren((settings.arguments as Map)["tweet"], (settings.arguments as Map)["index"]));
      case '/addTweet':
        return MyRouter.get_route_if_logged_in(const AddTweetScreen());
      case '/quotesList':
        return MyRouter.get_route_if_logged_in(QuotesListScreen(settings.arguments as int));
      case '/retweetsList':
        return MyRouter.get_route_if_logged_in(RetweetsListScreen(settings.arguments as int));
      case '/quoteTweet':
        return MyRouter.get_route_if_logged_in(QuoteTweetScreen(settings.arguments as QuotedTweetModel));
      case '/takePhoto':
        return MyRouter.get_route_if_logged_in<MediaPickerCubit>(TakePictureScreen(), settings.arguments as MediaPickerCubit);
      case '/selectMedia':
        return MyRouter.get_route_if_logged_in<MediaPickerCubit>(SelectMediaScreen(), settings.arguments as MediaPickerCubit);
      case '/replyToTweet':
        return MyRouter.get_route_if_logged_in<AddReplyBloc>(ReplyToTweetScreen((settings.arguments as Map)["tweet"]), (settings.arguments as Map)["addReplyBloc"]);
      case '/tweetDetails':
        return MyRouter.get_route_if_logged_in(TweetScreen(settings.arguments));
      case '/userFollowers':
        final args = settings.arguments as Map<String, dynamic>;
        return MyRouter.get_route_if_logged_in(UserFollowerScreen(args['lookingFor'], args['username']));
      case '/userDetails':
        return MyRouter.get_route_if_logged_in(UserDetailsCreen(settings.arguments));
      case '/home':
        return MyRouter.get_route_if_logged_in(HomeScreen());
      case '/register':
        return MyRouter.logout_and_get_route(RegisterScreen());
      case '/confirmEmail':
        return MyRouter.logout_and_get_route(EmailConfirmationScreen(settings.arguments));
      case '/passwordReset':
        return MyRouter.logout_and_get_route(PasswordResetScreen());
      case '/passwordResetConfirm':
        return MyRouter.logout_and_get_route(PasswordResetConfirmScreen(settings.arguments));
      case '/login':
        return MyRouter.logout_and_get_route(LoginScreen());
      case '/':
        return MyRouter.entryRoute();
      default:
        return MyRouter.logout_and_get_route(LoginScreen());
    }
  }
  
  static Route<dynamic> get_route_if_logged_in<T extends BlocBase>(Widget route, [BlocBase? bloc]) {
    return MaterialPageRoute(
      builder: (context) => FutureBuilder(
        future: is_logged_in(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData) {
              if(snapshot.data == false) {
                Future.delayed(const Duration(microseconds: 0), () { 
                    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false); 
                  }
                );
              } else {
                if(bloc != null) {
                  return BlocProvider<T>.value(
                    value: bloc as T,
                    child: route,
                  );
                }
                return route;
              }
            }
            return const Scaffold();
          }
          return const Scaffold();
        },
      )
    );
  }

  static Route<dynamic> logout_and_get_route(Widget route) {
    return MaterialPageRoute(
      builder: (context) => FutureBuilder(
        future: log_out(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData) {
                return route;
            }
            return const Scaffold();
          }
          return const Scaffold();
        },
      )
    );
  }

  static Route<dynamic> entryRoute() {
    return MaterialPageRoute(builder: (context) {
        return GetIt.I<CurrentUserService>().isUserAvailable() ?
              const HomeScreen()
              : const LoginScreen();
      }
    );
  }
   
}