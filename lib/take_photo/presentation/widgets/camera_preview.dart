import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraPreviewWidget extends StatefulWidget {
  CameraPreviewWidget(this.takePicture, this.startRecording, this.stopRecording, {super.key});
  Function takePicture;
  Function startRecording;
  Function stopRecording;

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> with WidgetsBindingObserver {

  CameraController? _cameraController;
  late Future<void> _initializeCamera;
  bool _isCapturePhotoChosen = true;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera = initializeCamera();
  } 

  Future<void> initializeCamera([int cameraIndex = 0]) async{
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[cameraIndex], ResolutionPreset.max, imageFormatGroup: ImageFormatGroup.yuv420);
    return await _cameraController!.initialize(); 
  }

  void toggleCamera() {
    if(_cameraController!.value.isInitialized) {
      if(_cameraController!.description.lensDirection == CameraLensDirection.back) {
        setState(() {
          // 1 is index of front camera
          _initializeCamera = initializeCamera(1);
        });
      } else {
        setState(() {
          // 0 is index of back camera
          _initializeCamera = initializeCamera(0);
        });
      }
    }
  }

  toggleToCapturePhoto(PageController pageController) async {
    // the number "0" means the pageview is at "VIDEO"
    if(pageController.page == 0) {
      await pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      setState(() {
        _isCapturePhotoChosen = true;
      });
    }
  }

  toggleToVideo(PageController pageController) async {
    // the number "1" means the pageview is at "CAPTURE"
    if(pageController.page == 1) {
      await pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      setState(() {
        _isCapturePhotoChosen = false;
      });
    }
  }

  circleClicked() {
    if(_isCapturePhotoChosen) {
      widget.takePicture(_cameraController);
    } else if(_isRecording) {
      widget.stopRecording(_cameraController);
    } else {
      widget.startRecording(_cameraController);
      setState(() {
        _isRecording = true;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      setState(() {
        _initializeCamera = initializeCamera();
      });
    } else if(state == AppLifecycleState.inactive) {
      _cameraController!.dispose();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: FutureBuilder(
                    future: _initializeCamera,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_cameraController!);
                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      
                    }
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white,)
                      ),
                  )
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      onPressed: toggleCamera,
                      icon: const Icon(Icons.flip_camera_android, color: Colors.white,)
                      ),
                  )
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: circleClicked,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(microseconds: 100),
                          curve: Curves.easeOut,
                          width: 73,
                          height: 73,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: _isCapturePhotoChosen ? Colors.grey.withOpacity(0.6) : _isRecording ? Colors.white : Colors.red
                          ),
                          child: _isRecording ? const Icon(Icons.stop_rounded, color: Colors.red, size: 55,) : null
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ) 
        ),
        SizedBox(height: 100, child: TakePhotoOrVideoButtons(toggleToCapturePhoto, toggleToVideo),)
      ],
      
    );
  }
}

class TakePhotoOrVideoButtons extends StatelessWidget {
  TakePhotoOrVideoButtons(this.toggleToCapturePhoto, this.toggleToVideo, {super.key});
  Function toggleToCapturePhoto;
  Function toggleToVideo;
  PageController _pageController = PageController(initialPage: 1, viewportFraction: 0.333);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20,),
      child: PageView(
        controller: _pageController,
        children: [
          GestureDetector(
            onTap: () => toggleToVideo(_pageController),
            child: Container(
              alignment: Alignment.topCenter,
              child: Text("VIDEO")
            ),
          ),
          GestureDetector(
            onTap: () => toggleToCapturePhoto(_pageController),
            child: Container(
              alignment: Alignment.topCenter,
              child: Text("CAPTURE")
            ),
          )
        ],
      ),
    );
  }
}