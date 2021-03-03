import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:flutter/painting.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
// Remove image cache after sending image to the server.
//imageCache.clear();
//PaintingBinding.instance.imageCache.clear()

//https://brainsandbeards.com/blog/how-to-add-camera-support-to-a-flutter-app
class TakePictureScreen extends StatefulWidget {
  static const id = 'take_picture_screen';

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  CameraController controller;
  // ignore: unused_field
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  bool enableAudio = true;
  // ignore: unused_field
  double _minAvailableExposureOffset = 0.0;
  // ignore: unused_field
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom;
  double _maxAvailableZoom;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  XFile imageFile;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
      onNewCameraSelected(controller.description);
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  // ignore: override_on_non_overriding_member // TODO: Add this for Android
  void didChangeAppLifecycleState(AppLifecycleState state) {
  // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      //enableAudio: enableAudio,
      //imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
      await Future.wait([
        controller
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        controller
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        controller.getMaxZoomLevel().then((value) => _maxAvailableZoom = value),
        controller.getMinZoomLevel().then((value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // ignore: unnecessary_brace_in_string_interps
      showInSnackBar('Camera error ${e}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (details) => onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller.setExposurePoint(offset);
    controller.setFocusPoint(offset);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller.setZoomLevel(_currentScale);
  }

  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      print(file.path.toString());
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed(BuildContext context) {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          // videoController?.dispose();
          // videoController = null;
        });
        if (file != null) {
          print('SECOND: ${file.path}');
          // showInSnackBar('Picture saved to ${file.path}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(
                imagePath: imageFile.path,
              ),
            ),
          );
        }
      }
    });
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    scaffoldMessengerKey.currentState
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'Daily Environment Survey'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'If you would like to include a picture, it cannot be transmitted to LDEQ but can provide evidence for citizen records.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: _cameraPreviewWidget(),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                // border: Border.all(
                //   color: controller != null ? Colors.redAccent : Colors.grey,
                //   width: 3.0,
                // ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 46.0),
                color: Colors.blue,
                onPressed: () {
                  onTakePictureButtonPressed(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(1.0),
              child: Center(
                child: Image.file(
                  File(imagePath),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(Icons.send_rounded, size: 46.0),
                color: Colors.blue,
                onPressed: () {
                  //onTakePictureButtonPressed(context);
                  final imageFile =
                      p.dirname(imagePath) + '${DateTime.now()}.jpeg';
                  print(imageFile);
                  imageSentDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future imageSentDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thank you!'),
        content: const Text(
          'Image was sent to the server.  Would you like to finish or file complaint with the State of Louisiana today?',
        ),
        actions: [
          TextButton(
            child: const Text('Finish'),
            onPressed: () {
              Navigator.popAndPushNamed(context, PaticipantNavScreen.id);
            },
          ),
          TextButton(
            child: const Text('File complaint'),
            onPressed: () {
              launch(Const.LDEQ_COMPLAINT_URL);
            },
          )
        ],
      );
    },
  );
}
//cameraPreview(),
// Container(
//   height: size.height * 0.7,
//   padding: EdgeInsets.symmetric(horizontal: 20.0),
//   decoration: BoxDecoration(color: Colors.amberAccent),
// ),
// FloatingActionButton(
//   child: Icon(Icons.camera_alt),
//   onPressed: () async {
//     try {
//       await _initializeControllerFuture;
//       final image = await controller.takePicture();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DisplayPictureScreen(
//             imagePath: image?.path,
//           ),
//         ),
//       );
//     } catch (e) {
//       print(e);
//     }
//   },
// ),
