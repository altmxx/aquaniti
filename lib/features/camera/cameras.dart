// THis is a file created via youtube
//This Camera Controller

import 'dart:developer';

import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScanProvider with ChangeNotifier {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  CancelableOperation<void>? _debounceOperation;
  final Duration _debounceDuration = Duration(milliseconds: 10000);

  var _isCameraInitialized = false;
  var _cameraCount = 0;

  var _x, _y, _w, _h = 0.0;
  var _label = "";

  CameraController get cameraController => _cameraController;
  List<CameraDescription> get cameras => _cameras;
  CameraImage get cameraImage => _cameraImage;
  bool get isCameraInitialized => _isCameraInitialized;
  double get x => _x;
  double get y => _y;
  double get w => _w;
  double get h => _h;
  String get label => _label;

  set cameraController(CameraController value) {
    _cameraController = value;
    notifyListeners();
  }

  set cameras(List<CameraDescription> value) {
    _cameras = value;
    notifyListeners();
  }

  set cameraImage(CameraImage value) {
    _cameraImage = value;
    notifyListeners();
  }

  set x(double val) {
    _x = val;
    notifyListeners();
  }

  set y(double val) {
    _y = val;
    notifyListeners();
  }

  set w(double val) {
    _w = val;
    notifyListeners();
  }

  set h(double val) {
    _h = val;
    notifyListeners();
  }

  disposeCamera() {
    _cameraController.dispose();
    log("Camera COntroller disposed");
    notifyListeners();
  }

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      _cameras = await availableCameras();
      _cameraController = CameraController(_cameras[0], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.yuv420);
      await _cameraController.initialize().then((value) {
        cameraController.startImageStream((image) => objectDetector(image));
      });
      _isCameraInitialized = true;
      notifyListeners();
    } else {
      print("Permission Denied");
    }
  }

  objectDetector(CameraImage image) async {
    if (_debounceOperation != null && !_debounceOperation!.isCompleted) {
      _debounceOperation!.cancel();
    }
    _debounceOperation = CancelableOperation.fromFuture(
      _runObjectDetection(image),
      onCancel: () {},
    );
  }

  Future<void> _runObjectDetection(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4,
    );

    if (detector != null) {
      var ourDetectedObject = detector.first;
      log(detector.toString());
      if (ourDetectedObject['confidenceInClass'] * 100 > 45) {
        _label = ourDetectedObject['detectedClass'].toString();
        _h = ourDetectedObject['rect']['h'] ??
            0.0; // Add null check and default value
        _w = ourDetectedObject['rect']['w'] ??
            0.0; // Add null check and default value
        _x = ourDetectedObject['rect']['x'] ??
            0.0; // Add null check and default value
        _y = ourDetectedObject['rect']['y'] ?? 0.0;
        log("Result is $detector");
      }
      notifyListeners();
    }
  }
}
