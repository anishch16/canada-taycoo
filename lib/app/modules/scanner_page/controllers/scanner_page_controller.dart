import 'dart:convert';
import 'dart:ui' as ui;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/remote/api_client.dart';
import '../../../data/remote/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../../data/remote/models/data_success_model.dart';

// class ScannerPageController extends GetxController {
//   //TODO: Implement ScannerPageController
//   final count = 0.obs;
//   var barcode = ''.obs;
//   var searchByNumber = false.obs;
//   var qrCode = ''.obs; // Observable variable for QR code
//   var camState = false.obs; // Observable for camera state
//   var dirState = false.obs; //// Observable for camera direction
//   MobileScannerController  mobileScannerController = MobileScannerController();
//   // void toggleCamera() {
//   //   camState.value = !camState.value;
//   // }
//   //
//   // void swapBackLightState() async {
//   //   QrCamera.toggleFlash();
//   // }
//
//   void setBarcode(String value) {
//     barcode.value = value;
//   }
//   void searchNumber(bool value) {
//     searchByNumber.value = value;
//   }
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   void increment() => count.value++;
// }

class ScannerPageController extends GetxController {
  var scanResult = Rx<ScanResult?>(null);
  var responseModelData = Rx<ResponseModel?>(null);
  var aspectTolerance = 0.00.obs;
  var numberOfCameras = 0.obs;
  var selectedCamera = (-1).obs;
  var useAutoFocus = true.obs;
  var autoEnableFlash = false.obs;
  var globalKeys = [].obs;

  final flashOnController = TextEditingController(text: 'Flash on');
  final flashOffController = TextEditingController(text: 'Flash off');
  final cancelController = TextEditingController(text: 'Cancel');

  static final _possibleFormats = BarcodeFormat.values.toList()..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void onInit() {
    super.onInit();
    testGetCardList();
    // globalKeys.clear();
    // for (var i = 0; i < 1; i++) {
    //   globalKeys.add(GlobalKey());
    // }
    _getNumberOfCameras();
  }

  Future<void> _getNumberOfCameras() async {
    numberOfCameras.value = await BarcodeScanner.numberOfCameras;
  }

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': cancelController.text,
            'flash_on': flashOnController.text,
            'flash_off': flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: selectedCamera.value,
          autoEnableFlash: autoEnableFlash.value,
          android: AndroidOptions(
            aspectTolerance: aspectTolerance.value,
            useAutoFocus: useAutoFocus.value,
          ),
        ),
      );
      scanResult.value = result;
    } on PlatformException catch (e) {
      scanResult.value = ScanResult(
        rawContent: e.code == BarcodeScanner.cameraAccessDenied ? 'The user did not grant the camera permission!' : 'Unknown error: $e',
      );
    }
  }

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

  Future<ResponseModel?> getCardList() async {
    try {
      http.Response response = await ApiClient().getRequest(ApiUrls.BASE_URL + ApiUrls.LOGIN);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(jsonData);
        return responseModel;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  void testGetCardList() async {
    String mockJson = await rootBundle.loadString('assets/json/mock_json.json');
    Map<String, dynamic> jsonData = json.decode(mockJson);
    ResponseModel responseModel = ResponseModel.fromJson(jsonData);
    responseModelData.value = responseModel;
    globalKeys.value = List.generate(responseModel.data?.items?.length ?? 0, (index) => GlobalKey());
    print('Success: ${responseModel.success}');
    print('Message: ${responseModel.message}');
    print('Order ID: ${responseModel.data?.orderId}');
    print('Items:');
    responseModel.data?.items?.forEach((item) {
      print('  Item ID: ${item.itemId}');
      print('  Quantity: ${item.quantity}');
      print('  Description: ${item.itemDescription}');
      print('  Pick Area No: ${item.pickArea?.pickAreaNo}');
    });
  }
}
