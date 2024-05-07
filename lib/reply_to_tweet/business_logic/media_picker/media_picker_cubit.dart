import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_picker_state.dart';

class MediaPickerCubit extends Cubit<List<Map>> {
  MediaPickerCubit() : super(<Map>[]);

  mediaInputChanged(String? title, File selectedMedia) {
    List<Map> newState = List.from(state);
    if(newState.any((media) => media['title'] == title)) {
      newState.removeWhere((media) => media["title"] == title);
    } else {
      if(newState.length < 4) {
        newState.add({"title" : title, "file" : selectedMedia});
      }
    }
    emit(newState);
  }
}
