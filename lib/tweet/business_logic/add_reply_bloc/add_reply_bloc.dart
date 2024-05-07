import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/home/data/models/reply_tweet_model.dart';
import 'package:twitter_demo/tweet/data/repositories.dart';
import 'package:twitter_demo/utils/custom_exceptions.dart';

part 'add_reply_event.dart';
part 'add_reply_state.dart';

class AddReplyBloc extends Bloc<AddReplyEvent, AddReplyState> {
  AddReplyBloc() : super(AddReplyInitial()) {
    on<AddReply>(addReply);
  }

  addReply(event, emit) async {
    try {
      emit(AddReplyLoading());
      ReplyTweetModel reply = await TweetDetailsRepository.addReply(event.related_to, text: event.text, files: event.files);
      emit(AddReplyLoaded(reply));
    } on TweetNotFoundException {
      emit(AddReplyTweetNotFound());
    } catch(e) {
      emit(AddReplyError());
    }
  }

  @override
  Future<void> close() {
    print("AddReplyBloc closed");
    return super.close();
  }
  
}
