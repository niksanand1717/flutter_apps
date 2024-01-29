import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera_practice/home_page.dart';
import 'package:camera_practice/camera_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  late CameraController controller;
  late Future<void> initializeControllerFuture;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller = ref.watch(cameraProvider.notifier).cameraController();
    initializeControllerFuture = controller.initialize();
    return MaterialApp(
      title: 'Camera Provider',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(
        initializeControllerFuture: initializeControllerFuture,
        controller: controller,
      ),
    );
  }
}
