import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/reply_input_cubit/reply_input_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/small_video_preview.dart';

class MediaPickerInput extends StatefulWidget {
  const MediaPickerInput({super.key});

  @override
  State<MediaPickerInput> createState() => _MediaPickerInputState();
}

class _MediaPickerInputState extends State<MediaPickerInput> with TickerProviderStateMixin {
  List _latestMediaInGallery = [];
  bool? _hideMediaPicker;
  late final AnimationController _animationController = AnimationController(
    duration: Duration(milliseconds: 150), 
    vsync: this
  );
  late final Animation<double> _animation = Tween<double>(
    begin: 1,
    end: 0
  ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

  @override
  void initState() {
    super.initState();
    _hideMediaPicker = false;
  }

  Future<List> pickLatestMedias() async {
    await Future.delayed(Duration(milliseconds: 10));
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      final albums = await PhotoManager.getAssetPathList(
          hasAll: true, type: RequestType.common);
      if (albums.isNotEmpty) {
        final media =  await albums[0].getAssetListRange(start: 0, end: 20);
        for(var media in media) {
          _latestMediaInGallery.add({"title" : media.title, "file" : await media.file});
        }
         
      }
    }
    return _latestMediaInGallery;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: pickLatestMedias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return BlocConsumer<ReplyInputCubit, ReplyInputState>(
              listener: (context, state) {
                _hideMediaPicker = state.isTextFilled! || state.isMediaselected!;
                _hideMediaPicker == true ? _animationController.forward() : _animationController.reverse();
              },
              // We only need the _animationController to either go forward() or reverse(), no rebuild is required
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return SizeTransition(
                  axis: Axis.vertical,
                  axisAlignment: 0,
                  sizeFactor: _animation,
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.all(5),
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            width: 80,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 4),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(color: Colors.blue, width: 0.5)
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pushNamed("/takePhoto", arguments: context.read<MediaPickerCubit>()),
                              icon: const Icon(
                                Icons.camera_enhance_outlined,
                                color: Colors.blue,
                                size: 30,
                              )
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                          return MediaPreviewInMediaPickerInput(_latestMediaInGallery[index]);
                          }, 
                          childCount: _latestMediaInGallery.length)
                        ),
                        SliverToBoxAdapter(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/selectMedia", arguments: BlocProvider.of<MediaPickerCubit>(context));
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 4),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                      color: Colors.blue, width: 0.5)),
                              child: const Icon(
                                Icons.image_outlined,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                );
              },
            );
          } else {
            return const SizedBox();
          }
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MediaPreviewInMediaPickerInput extends StatelessWidget {
  MediaPreviewInMediaPickerInput(this._mediaData, {super.key});
  final _mediaData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => context.read<MediaPickerCubit>().mediaInputChanged(_mediaData["title"], _mediaData["file"]),
        child: _mediaData["title"].split(".").last != "mp4" ? 
                Image.file(_mediaData["file"],fit: BoxFit.cover)
                : VideoPreviewInMediaSelection(_mediaData["file"])
      )
    );
  }
}