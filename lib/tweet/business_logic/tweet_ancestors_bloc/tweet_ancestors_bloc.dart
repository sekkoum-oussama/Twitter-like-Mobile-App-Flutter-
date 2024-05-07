import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';

part 'tweet_ancestors_event.dart';
part 'tweet_ancestors_state.dart';

class TweetAncestorsBloc extends Bloc<TweetAncestorsEvent, TweetAncestorsState> {
  TweetAncestorsBloc() : super(TweetAncestorsInitial()) {
    on<GetTweetAncestors>(getTweetAncestors);
  }

  getTweetAncestors(event, emit) async {
    try {
      List tweets = await TweetDetailsRepository.getTweetAncestors(event.id);
      emit(TweetAncestorsLoaded(tweets));
    } catch(e) {
      emit(TweetAncestorsError());
    }
    
  }
}
