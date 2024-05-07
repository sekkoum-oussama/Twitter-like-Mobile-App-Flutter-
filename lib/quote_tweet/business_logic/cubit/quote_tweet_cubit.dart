import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_demo/tweet/data/repositories.dart';
part 'quote_tweet_state.dart';

class QuoteTweetCubit extends Cubit<QuoteTweetState> {
  QuoteTweetCubit() : super(QuoteTweetInitial());

  quoteTweet(related_to, {String? text, List? files}) async {
    emit(QuoteTweetLoading());
    try {
      final statusCode = await TweetDetailsRepository.quoteTweet(related_to, text: text, files: files);
      if(statusCode == 201) {
        emit(TweetQuoted());
      } else {
        emit(QuoteTweetError());
      }
    } catch(e) {
      emit(QuoteTweetError());
    }
  }
}
