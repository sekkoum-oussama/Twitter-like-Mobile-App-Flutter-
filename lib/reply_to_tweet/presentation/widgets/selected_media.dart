import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/small_video_preview.dart';

class SelectedMedia extends StatefulWidget {
  const SelectedMedia({super.key});

  @override
  State<SelectedMedia> createState() => _SelectedMediaState();
}

class _SelectedMediaState extends State<SelectedMedia> {
  List _selectedMedia = [];
  final _animatedListKey = GlobalKey<AnimatedListState>();
  bool? isMediaSelected;
  @override
  void initState() {
    super.initState();
    _selectedMedia = context.read<MediaPickerCubit>().state;
    isMediaSelected = _selectedMedia.isNotEmpty ? true : false;
    BlocProvider.of<MediaPickerCubit>(context).stream.listen((newState) {
      // 1. Remove a media from _selectedMedia if it is not present in the newState
      _selectedMedia.removeWhere((element) {
        if (!newState.contains(element)) {
          _animatedListKey.currentState!.removeItem(
              _selectedMedia.indexOf(element),
              (context, animation) => FadeTransition(
                    opacity: animation,
                    child: MediaChildInAnimatedList(element),
                  ));
          return true;
        }
        return false;
      });
      // 2. Add a media in _selectedMedia if it's present in newState
      newState.forEach((element) {
        if (!_selectedMedia.contains(element)) {
          _selectedMedia.add(element);
          _animatedListKey.currentState!
              .insertItem(_selectedMedia.indexOf(element));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaPickerCubit, List<Map>>(
      listener: (context, state) {
        isMediaSelected = state.isNotEmpty ? true : false;
      },
      builder: (context, state) {
        return SliverToBoxAdapter(
            child: Container(
          height: isMediaSelected! ? 170 : 0,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: AnimatedList(
              key: _animatedListKey,
              scrollDirection: Axis.horizontal,
              initialItemCount: _selectedMedia.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                    opacity: animation,
                    child: MediaChildInAnimatedList(_selectedMedia[index]));
              }),
        ));
      },
    );
  }
}

class MediaChildInAnimatedList extends StatefulWidget {
  MediaChildInAnimatedList(this.media, {super.key});
  final Map media;

  @override
  State<MediaChildInAnimatedList> createState() =>
      _MediaChildInAnimatedListState();
}

class _MediaChildInAnimatedListState extends State<MediaChildInAnimatedList> {
  bool? _isMediaAPhoto;
  File? file;

  @override
  void initState() {
    super.initState();
    _isMediaAPhoto = widget.media["title"].split(".").last != "mp4";
    file = widget.media["file"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      width: 140,
      height: 90,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Positioned.fill(
              child: _isMediaAPhoto!
                  ? Image.file(
                      file!,
                      fit: BoxFit.cover,
                    )
                  : VideoPreviewInMediaSelection(file!)),
          Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => BlocProvider.of<MediaPickerCubit>(context)
                    .mediaInputChanged(widget.media["title"], file!),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black.withOpacity(0.6),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
