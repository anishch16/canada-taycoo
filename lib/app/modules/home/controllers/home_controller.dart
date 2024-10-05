import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<String> orders = ["00000001", "00000002", "00000003", "00000004", "00000005"];
  List<String> items = ["X-ABCD-000000X", "X-ABCD-000001X", "X-ABCD-000002X", "X-ABCD-000003X", "X-ABCD-000004X"];
  List<GlobalKey> globalKeys = [];
  final count = 0.obs;

  @override
  void onInit() {
    globalKeys.clear();
    for (var i = 0; i < orders.length; i++) {
      globalKeys.add(GlobalKey());
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final GlobalKey globalKey = GlobalKey();

  // Request storage permission
  Future<void> requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> capturePng(int index) async {
    try {
      await requestStoragePermission();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        RenderRepaintBoundary? boundary = globalKeys[index].currentContext?.findRenderObject() as RenderRepaintBoundary?;

        if (boundary == null) {
          Get.snackbar(
            'Error',
            'Render object is null. Unable to capture image.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        ui.Image image = await boundary.toImage();
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Save the image to the gallery
        final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "screenshot_$index");

        if (result['isSuccess']) {
          Get.snackbar(
            'Download Complete',
            'Image saved to gallery.',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Error',
            'Unable to save image to gallery.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Future<void> capturePng() async {
  //   try {
  //     await requestStoragePermission();
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  //       if (boundary == null) {
  //         Get.snackbar(
  //           'Error',
  //           'Render object is null. Unable to capture image.',
  //           snackPosition: SnackPosition.BOTTOM,
  //         );
  //         return;
  //       }
  //
  //       ui.Image image = await boundary.toImage();
  //       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //       Uint8List pngBytes = byteData!.buffer.asUint8List();
  //       final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "screenshot");
  //
  //       if (result['isSuccess']) {
  //         Get.snackbar(
  //           'Download Complete',
  //           'Image saved to gallery.',
  //           snackPosition: SnackPosition.BOTTOM,
  //         );
  //       } else {
  //         Get.snackbar(
  //           'Error',
  //           'Unable to save image to gallery.',
  //           snackPosition: SnackPosition.BOTTOM,
  //         );
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar(
  //       'Error',
  //       'Something went wrong: $e',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
  void increment() => count.value++;
}
