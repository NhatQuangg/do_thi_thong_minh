import 'dart:io';

import 'package:align_positioned/align_positioned.dart';
import 'package:camera/camera.dart';
// import 'package:do_thi_thong_minh/pages/cretae_reflect/form_reflect_page.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/form_reflect_page/form_reflect_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:video_player/video_player.dart';

class CameraGuiPhanAnhScreen extends StatefulWidget {
  FormReflectPageState parent;

  CameraGuiPhanAnhScreen(this.parent) : super();

  @override
  CameraGuiPhanAnhScreenState createState() =>
      CameraGuiPhanAnhScreenState(this.parent);
}

class CameraGuiPhanAnhScreenState extends State<CameraGuiPhanAnhScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  FormReflectPageState parent;

  CameraGuiPhanAnhScreenState(this.parent) : super();

  CameraController? cameraController;
  List? cameras;
  late int selectedCameraIndex;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  XFile? videoFile;

  bool record = false;

  bool isRecording = false;

  Future<void> initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    cameraController?.setFlashMode(FlashMode.off);

    if (cameraController!.value.hasError) {
      print('Camera Error ${cameraController!.value.errorDescription}');
    }

    try {
      await cameraController!.initialize();
    } catch (e) {
      String errorText = 'Err';
      print("errorText ${e.toString()}");
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras!.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras![selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras!.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIndex];
    initCamera(selectedCamera);
  }

  onCapture(context) async {
    try {
      // final p = await getTemporaryDirectory();
      // final name = DateTime.now();
      // final path = "${p.path}/$name.png";

      XFile value = await cameraController!.takePicture();
      print('Take sentiment picture');
      parent.setState(() {
        parent.listFile.add(File(value.path));
      });
      Navigator.pop(context);
    } catch (e) {
      // showCameraException(e);
    }
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  void dispose() async {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    await cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(top: 0, left: 0, right: 0, child: cameraPreview()),
            AlignPositioned(
              alignment: Alignment.topLeft,
              dx: 10,
              dy: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Quay lại",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            AlignPositioned(
                alignment: Alignment.bottomCenter,
                dy: -110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            print("chụp");
                            record = false;
                          });
                        },
                        child: Text(
                          "CHỤP",
                          style: TextStyle(
                              color: record ? Colors.grey : Colors.white,
                              fontWeight:
                                  record ? FontWeight.normal : FontWeight.bold),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            print("quay");
                            record = true;
                          });
                        },
                        child: Text("VIDEO",
                            style: TextStyle(
                                color: record ? Colors.white : Colors.grey[300],
                                fontWeight: record
                                    ? FontWeight.bold
                                    : FontWeight.normal))),
                  ],
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Spacer(),
                    cameraControl(context),
                    cameraToggle(),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 30,
                bottom: 30,
                child: InkWell(
                  onTap: () async {
                    try {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true, type: FileType.media);
                      print('PICKER FILE $result');

                      if (result != null) {
                        print('PICKER FILE RESULT');

                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                        parent.setState(() {
                          parent.listFile.addAll(files);
                          for (File e in parent.listFile) {
                            print("File ${e.path}");
                          }
                        });
                        Navigator.pop(context);
                      } else {
                        print('CANNOT PICKER FILE');
                      }
                    } catch (e) {
                      print('CANNOT PICKER FILE ${e.toString()}');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width / 9,
                    height: MediaQuery.of(context).size.width / 9,
                    child: Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Center(
        child: Text(
          'Loading',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      );
    }

    return CameraPreview(cameraController!);
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            record
                ? FloatingActionButton(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: isRecording
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      if (isRecording) {
                        stopVideoRecording().then((value) async {
                          parent.setState(() {
                            parent.listFile.add(File(value!.path));
                          });
                          Navigator.pop(context);
                        });
                      } else {
                        startVideoRecording();
                      }
                    },
                  )
                : FloatingActionButton(
                    // child: Image.asset(
                    //   Res.ic_chupanh,
                    //   fit: BoxFit.cover,
                    //   width: 20,
                    //   height: 20,
                    // ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      onCapture(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget cameraToggle() {
    if (cameras == null || cameras!.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras![selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: isRecording
            ? SizedBox()
            : InkWell(
                onTap: () {
                  onSwitchCamera();
                },
                child: Icon(
                  getCameraLensIcons(lensDirection),
                  color: Colors.white,
                  size: 24,
                ),
              ),
      ),
    );
  }

  // Future<void> _startVideoPlayer() async {
  //   final VideoPlayerController vController =
  //   VideoPlayerController.file(File(videoFile.path));
  //   videoPlayerListener = () {
  //     if (videoController != null && videoController.value.size != null) {
  //       // Refreshing the state to update video player with the correct ratio.
  //       if (mounted) setState(() {});
  //       videoController.removeListener(videoPlayerListener);
  //     }
  //   };
  //   vController.addListener(videoPlayerListener);
  //   await vController.setLooping(true);
  //   await vController.initialize();
  //   await videoController?.dispose();
  //   if (mounted) {
  //     setState(() {
  //       // imageFile = null;
  //       videoController = vController;
  //     });
  //   }
  //   await vController.play();
  // }

  Future<void> startVideoRecording() async {
    final CameraController? cameraControllers = cameraController;

    if (cameraControllers == null || !cameraControllers.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraControllers.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraControllers.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } on CameraException {
      // _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraControllesr = cameraController;
    setState(() {
      isRecording = false;
    });
    if (cameraControllesr == null ||
        !cameraController!.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraControllesr.stopVideoRecording();
    } on CameraException {
      // _showCameraException(e);
      return null;
    }
  }
}
