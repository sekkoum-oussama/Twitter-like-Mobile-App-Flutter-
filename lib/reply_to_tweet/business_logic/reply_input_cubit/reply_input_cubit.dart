import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';

part 'reply_input_state.dart';


class ReplyInputCubit extends Cubit<ReplyInputState> {
  ReplyInputCubit(this._mediaPickerCubit) : super(ReplyInputState(isTextFilled: false, isMediaselected: false)) {
    _mediaPickerCubit.stream.listen((event) { 
        if(event.length > 0 && state.isMediaselected! == false) {
          emit(ReplyInputState(isTextFilled: state.isTextFilled, isMediaselected: true));
        } else if(event.length < 1 && state.isMediaselected!) {
          emit(ReplyInputState(isTextFilled: state.isTextFilled, isMediaselected: false));
        }
     }
    );
  }

  MediaPickerCubit _mediaPickerCubit;

  replyInputChanged(String text) {
    text = text.trim();
    if(text.isEmpty && state.isTextFilled!) {
      emit(ReplyInputState(isTextFilled: false, isMediaselected: state.isMediaselected));
    } else if(text.isNotEmpty && state.isTextFilled! == false) {
      emit(ReplyInputState(isTextFilled: true, isMediaselected: state.isMediaselected));
    }
  }
}
