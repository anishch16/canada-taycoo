import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPageController extends GetxController {
  //TODO: Implement ScannerPageController
  final count = 0.obs;
  var barcode = ''.obs;
  var searchByNumber = false.obs;
  var qrCode = ''.obs; // Observable variable for QR code
  var camState = false.obs; // Observable for camera state
  var dirState = false.obs; //// Observable for camera direction
  MobileScannerController  mobileScannerController = MobileScannerController();
  // void toggleCamera() {
  //   camState.value = !camState.value;
  // }
  //
  // void swapBackLightState() async {
  //   QrCamera.toggleFlash();
  // }

  void setBarcode(String value) {
    barcode.value = value;
  }
  void searchNumber(bool value) {
    searchByNumber.value = value;
  }
  @override
  void onInit() {
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

  void increment() => count.value++;
}