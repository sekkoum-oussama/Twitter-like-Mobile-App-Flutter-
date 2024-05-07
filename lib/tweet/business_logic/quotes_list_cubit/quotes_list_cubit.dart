import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'quotes_list_state.dart';

class QuotesListCubit extends Cubit<QuotesListState> {
  QuotesListCubit() : super(QuotesListInitial());

  getTweetQuotes(int id) async {
    try {
      emit(QuotesListLoading());
      List<QuoteTweetModel> quotesTweets = await TweetDetailsRepository.getTweetQuotes(id);
      emit(QuotesListLoaded(quotesTweets));
    } on TweetNotFoundException {
      emit(TweetNotFoundState());
    } catch(e) {
      emit(QuotesListErrorState());
    }

  }
}
