import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../data/remote/api_client.dart';
import '../../../data/remote/api_urls.dart';
import '../models/signin_response_model.dart';

class SigninController extends GetxController {
  //TODO: Implement SigninController

  var isLogging = false.obs;
  var passwordVisible = false.obs;
  var loginData = SignInResponseModel().obs;
  final localData = GetStorage();
  GlobalKey<FormState> formKey = GlobalKey();
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

  Future<void> login(String email, String pw) async {
    log("Login Tapped");
    isLogging.value = true;

    Map<String, dynamic> requestBody = {"email": email, "password": pw};
    Future<http.Response> response = ApiClient().postRequestWithoutToken(ApiUrls.BASE_URL + ApiUrls.LOGIN, requestBody);
    response.then((http.Response response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        SignInResponseModel loginResponseModel = SignInResponseModel.fromJson(jsonDecode(response.body));
        loginData.value = SignInResponseModel(refresh: loginResponseModel.refresh, access: loginResponseModel.access, user: loginResponseModel.user);
        storeData();
      } else {
        isLogging.value = false;
      }
    });
  }

  void storeData() {
    localData.write("isLoggedIn", true);
    localData.write("access_token", loginData.value.access);
    localData.write("full_name", loginData.value.user!.fullName);
    localData.write("email", loginData.value.user!.email);
    localData.write("hasFilledProfile", loginData.value.user!.hasFilledProfileInfo);
    if (loginData.value.user!.roles!.contains("HospitalManager") || loginData.value.user!.roles!.contains("HospitalAdmin")) {
      localData.write("isHospitalManager", true);
    } else {
      localData.write("isHospitalManager", false);
    }

    Get.rawSnackbar(
        message: "Successfully Logged In",
        backgroundColor: Colors.grey.shade800,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        snackPosition: SnackPosition.BOTTOM);
    log("access token:::${localData.read("access_token")}");
    isLogging.value = false;
    if (loginData.value.user!.hasFilledProfileInfo == false) {
      // Get.offAll(() => UserDetailFormView(),arguments:0);
    } else {
      // Get.offAll(() => BottomNavView());
    }
  }
}
