import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';

part 'add_tweet_state.dart';

class AddTweetCubit extends Cubit<AddTweetState> {
  AddTweetCubit() : super(AddTweetInitial());

  addTweet({String? text, List? files}) async {
    try {
      emit(AddTweetLoading());
      final response = await TweetDetailsRepository.addTweet(text: text, files: files);
      if(response["statusCode"] == 201) {
        emit(TweetAddedState());
      } else if (response["statusCode"] == 400){
        emit(AddTweetError((response["body"] as Map).values.first[0].toString()));
      } else {
        emit(AddTweetUnknownError());
      }
    } catch(e) {
      emit(AddTweetUnknownError());
    }
  }
}
