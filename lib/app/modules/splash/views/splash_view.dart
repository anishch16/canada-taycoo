import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.delayAndGo();
    return Scaffold(
      body:  Center(
        child: Image.asset(
          "assets/png/logo.png",
          height: 40,
        ),
      ),
    );
  }
}
