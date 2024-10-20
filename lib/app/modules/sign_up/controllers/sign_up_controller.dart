import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../data/remote/api_client.dart';
import '../../../data/remote/models/sign_up_response_model.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final count = 0.obs;
  var isLogging = false.obs;
  var loginData = SignUpResponseModel().obs;
  final signUpFormKey = GlobalKey<FormState>();
  final localData = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

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

  Future<void> signUp({required String email, required String password, required String confirmPassword}) async {
    log("Login Tapped");
    isLogging.value = true;
    Map<String, dynamic> requestBody = {"email": email, "password": password, "confirm_password": confirmPassword};
    Future<http.Response> response = ApiClient().postRequestWithoutToken("https://django-project-weld.vercel.app/user/register/", requestBody);
    response.then((http.Response response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        SignUpResponseModel loginResponseModel = SignUpResponseModel.fromJson(jsonDecode(response.body));
        loginData.value = SignUpResponseModel(message: loginResponseModel.message, token: loginResponseModel.token);
        log(":::::::::::::::::::::::::> Sign up successful <::::::::::::::::::::::::::");
        storeData();
        Get.offAllNamed(Routes.SCANNER_PAGE);
      } else {
        isLogging.value = false;
      }
    });
  }

  void storeData() {
    localData.write("isLoggedIn", true);
    localData.write("access_token", loginData.value.token?.access);
    Get.rawSnackbar(
        message: "Successfully Logged In",
        backgroundColor: Colors.grey.shade800,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        snackPosition: SnackPosition.BOTTOM);
    log("access token:::${localData.read("access_token")}");
    isLogging.value = false;
  }

  void increment() => count.value++;
}
