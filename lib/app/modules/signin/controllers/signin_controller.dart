import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../data/remote/api_client.dart';
import '../../../routes/app_pages.dart';
import '../models/signin_response_model.dart';

class SigninController extends GetxController {
  //TODO: Implement SigninController

  var isLogging = false.obs;
  var passwordVisible = true.obs;
  var loginData = SignInResponseModel().obs;
  final localData = GetStorage();
  final signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  Future<void> signIn({required String email, required String password}) async {
    log("Login Tapped");
    isLogging.value = true;
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    Future<http.Response> response = ApiClient().postRequestWithoutToken("https://django-project-weld.vercel.app/user/login/", requestBody);
    response.then((http.Response response) {
      print("Status code:::: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        SignInResponseModel loginResponseModel = SignInResponseModel.fromJson(jsonDecode(response.body));
        loginData.value = SignInResponseModel(message: loginResponseModel.message, token: loginResponseModel.token);
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
}
