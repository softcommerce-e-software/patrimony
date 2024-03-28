import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
        cameras.firstWhere((e) => e.lensDirection == CameraLensDirection.back),
        ResolutionPreset.medium);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Câmera",
        items: [],
      ),
      body: SafeArea(
        child: controller == null
            ? Container()
            : CameraPreview(controller!,),
      ),
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        onPressed: () async {
          try {
            if(controller != null && controller?.value.isInitialized == true) {
              final image = await controller?.takePicture();
              Navigator.pop(context, image?.path);
            }
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
