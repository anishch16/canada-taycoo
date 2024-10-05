import 'package:get/get.dart';

import '../controllers/scanner_page_controller.dart';

class ScannerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerPageController>(
      () => ScannerPageController(),
    );
  }
}
