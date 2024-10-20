import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final localData = GetStorage();

  void delayAndGo() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    log(":::::::::::::::: Function executed Successfully :::::::::::");
    if (localData.read('isLoggedIn') == true) {
      log(":::::::::::::: Already Logged In ::::::::::::::::::");
      Get.offAllNamed(Routes.SCANNER_PAGE);
    } else {
      log(":::::::::::::: Not Logged In ::::::::::::::::");
      Get.offAllNamed(
        Routes.SIGNIN,
      );
    }
  }
}
