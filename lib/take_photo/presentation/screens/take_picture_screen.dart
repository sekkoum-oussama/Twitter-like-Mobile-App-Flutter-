import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/reply_to_tweet/business_logic/media_picker/media_picker_cubit.dart';
import 'package:twitter_demo/take_photo/presentation/widgets/camera_preview.dart';
import 'package:twitter_demo/take_photo/presentation/widgets/use_photo.dart';


class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({super.key});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  XFile? _mediaTaken;
  bool _isMediaTaken = false;
  Timer? _videoTimer;


  takePicture(CameraController _cameraController) async {
    if(_cameraController.value.isTakingPicture || _cameraController.value.isRecordingVideo) {
      return;
    }
    try {
      await _cameraController.setFocusMode(FocusMode.locked);
      await _cameraController.setExposureMode(ExposureMode.locked);
      await _cameraController.setFlashMode(FlashMode.off);
      _mediaTaken = await _cameraController.takePicture();
      
      await _cameraController.setFocusMode(FocusMode.auto);
      await _cameraController.setExposureMode(ExposureMode.auto);
      setState(() {
          _isMediaTaken = true;
      });
      
    } on CameraException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong when taking picture")));
      return;
    }
  }

  startRecording(CameraController _cameraController) async {
    if(_cameraController.value.isTakingPicture || _cameraController.value.isRecordingVideo) {
      return;
    }
    await _cameraController.startVideoRecording();
    _videoTimer = Timer(Duration(seconds: 10), () => stopRecording(_cameraController));
  }

  stopRecording(CameraController _cameraController) async {
    _mediaTaken = await _cameraController.stopVideoRecording();
    _videoTimer!.cancel();
    setState(() {
      _isMediaTaken = true;
    });
  }

  retakeMedia() {
    setState(() {
      _isMediaTaken = false;
      _mediaTaken = null;
    });
  }

  useMedia(XFile media) {
    context.read<MediaPickerCubit>().mediaInputChanged(media.name, File(media.path));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: _isMediaTaken ? UsePhoto(
            mediaTaken: _mediaTaken, 
            retakeMedia: retakeMedia,
            useMedia: useMedia,
          ) : CameraPreviewWidget(takePicture, startRecording, stopRecording),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        )
      ),
    );
  }
}

