import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraProviderNotifier extends StateNotifier {
  CameraProviderNotifier() : super([]);

  List<CameraDescription>? cameras;

  Cameras() async => cameras = await availableCameras();

  CameraDescription frontCamera() {
    Cameras();
    return cameras!.last;
  }

  cameraController() {
    var frontcam = frontCamera();
    var _controller = CameraController(frontcam, ResolutionPreset.low);
    return _controller;
  }
}

final cameraProvider = StateNotifierProvider((ref) {
  // CameraProviderNotifier().Cameras();
  return CameraProviderNotifier();
});
