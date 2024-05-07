import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/reply_to_tweet/presentation/widgets/small_video_preview.dart';


class SelectMediaScreen extends StatelessWidget {
  SelectMediaScreen({super.key});
  List _mediaInGallery = [];

  Future loadMediaFromDevice() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
      );
      if (albums.isNotEmpty) {
        _mediaInGallery = await albums[0].getAssetListRange(start: 0, end: 50);
    }
    return _mediaInGallery; 
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadMediaFromDevice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return MediaGallery(snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
              
            return const Center(
              child: Text("Error loading images, please try later"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No media is found");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


class MediaGallery extends StatelessWidget {
  MediaGallery(this._medias, {super.key});
  List<AssetEntity> _medias;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: false,
      cacheExtent: 500,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        
      ),
      itemBuilder: (context, index) {
        return FutureBuilder(
            future: _medias[index].file,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return MediaElement( _medias[index].title, snapshot.data!);
              } else {
                return const SizedBox();
              }
            });
      },
      itemCount: _medias.length,
    );
  }
}

class MediaElement extends StatefulWidget {
  MediaElement(this.title, this.file, {super.key});
  final File file;
  final String? title;

  @override
  State<MediaElement> createState() => _MediaElementState();
}

class _MediaElementState extends State<MediaElement> {
  Widget? _aboveWidget;
  Widget? _newAboveWidget;

  @override
  void initState() {
    super.initState();
    if(BlocProvider.of<MediaPickerCubit>(context).state.any((element) => element["title"] == widget.title)) {
      _aboveWidget = _mediaSelectedOverlay;
    } else if(BlocProvider.of<MediaPickerCubit>(context).state.length > 3) {
      _aboveWidget = _mediaWithOpacityOverlay;
    } else {
      _aboveWidget = _mediaNotSelectedOverlay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: widget.title!.split(".").last != "mp4" ?  
                Image.file(widget.file,fit: BoxFit.cover,)
                : VideoPreviewInMediaSelection(widget.file)  
        ),
        BlocConsumer<MediaPickerCubit, List<Map>>(
          listener: (context, state) {
            if(state.any((element) => element["title"] == widget.title)) {
              _newAboveWidget = _mediaSelectedOverlay;
            } else if(state.length > 3) {
              _newAboveWidget = _mediaWithOpacityOverlay;
            } else {
              _newAboveWidget = _mediaNotSelectedOverlay;
            }
          },
          buildWhen: (previous, current) {
            if(_aboveWidget == _newAboveWidget) {
              return false;
            }
            _aboveWidget = _newAboveWidget;
            return true;
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: state.length > 3 && !state.any((element) => element["title"] == widget.title) ? 
                null : 
                () =>  BlocProvider.of<MediaPickerCubit>(context).mediaInputChanged(widget.title, widget.file),
              child: _aboveWidget
            );
          },
        ),
      ],
    );
  }

  final Widget _mediaSelectedOverlay = Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.green),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                      ),
                    ),
                  
                );

  final Widget _mediaNotSelectedOverlay = Container(color: Colors.transparent,);
  final _mediaWithOpacityOverlay = Container(color: Colors.white.withOpacity(0.5));
}
