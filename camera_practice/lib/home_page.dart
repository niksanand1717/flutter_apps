import 'package:camera_practice/camera_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:camera/camera.dart';

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage(
      {super.key,
      required this.initializeControllerFuture,
      required this.controller});

  Future<void> initializeControllerFuture;
  CameraController controller;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  // late CameraController controller;
  // late Future<void> initializeControllerFuture;
  var _image;

  // late CameraDescription frontCamera;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // controller = ref.watch(cameraProvider.notifier).cameraController();
    // initializeControllerFuture = controller.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera using provider"),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder(
                  future: widget.initializeControllerFuture,
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return
                            // CameraPreview(widget.controller);
                            Text('Miracle Miracle');
                      } else {
                        return CircularProgressIndicator();
                      }
                    } catch (e) {
                      return LinearProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 18.0,
                ),
                FloatingActionButton(
                    child: Icon(Icons.camera),
                    onPressed: () async {
                      try {
                        _image = await widget.controller.takePicture();
                        print(
                            "========================================= image captured" +
                                _image.path);
                      } catch (e) {
                        print(e);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
