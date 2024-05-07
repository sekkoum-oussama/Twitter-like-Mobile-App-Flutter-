import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/business_logic/tweet_replies_bloc/tweet_replies_bloc.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'retweet_list_state.dart';

class RetweetsListCubit extends Cubit<RetweetsListState> {
  RetweetsListCubit() : super(RetweetsListInitial());

  getRetweetsList(int id) async {
    try {
      emit(RetweetsListLoading());
      List users = await TweetDetailsRepository.getTweetRetweets(id);
      emit(RetweetsListLoaded(users));
    } on TweetNotFoundException catch(_) {
      print("object");
      emit(TweetNotFoundState());
    } on Exception {
      print("In catch");
      emit(RetweetsListError());
    } 
  }
}
