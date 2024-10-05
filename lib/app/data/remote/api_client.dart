import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../routes/app_pages.dart';
import 'models/error_response_model.dart';

class ApiClient {
  final localData = GetStorage();

  var errorResponseData = ErrorResponseModel().obs;

  // var refreshTokenData = RefreshTokenModel().obs;
  // final localData = GetStorage();

  //get method
  Future<http.Response> getRequest(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "'Bearer '${localData.read('access_token')}",
        },
      );
      log("Response::::::::${response.body}");
      log("Response statusCode ::::::::${response.statusCode}");
      if (response.statusCode == 401) {
        localData.erase();
        Get.offAllNamed(Routes.HOME);
        Get.rawSnackbar(
          message: 'Token Expired Please Login Again',
          backgroundColor: Colors.grey.shade600,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      // else if (response.statusCode == 204) {
      //   print('No Content returned::::::::::::::::::');
      //   Get.back();
      //   Get.rawSnackbar(
      //     message: 'No data found',
      //     backgroundColor: AppColors.grey.shade600,
      //     duration: Duration(seconds: 1),
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // }

      else if (response.statusCode != 200) {
        log("Response we get:::::::::::${response.body}");
        if(response.body.isNotEmpty){
          var errorMap = jsonDecode(response.body);
          var errorMessage = extractErrorMessage(errorMap);
          showErrorMessage(errorMessage);
        } else {
          Get.back();
          showErrorMessage("Empty Data");
        }
      }
      return response;
    } catch (error, stackTrace) {
      log('An error occurred: $error');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  //post method
  Future<http.Response> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "'Bearer '${localData.read('access_token')}",
          },
          body: body);
      log("Response::::::::${response.body}");
      if (response.statusCode == 401) {
        localData.erase();
        Get.offAllNamed(Routes.HOME);
        Get.rawSnackbar(
          message: 'Token Expired Please Login Again',
          backgroundColor: Colors.grey.shade600,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode > 201) {
        var errorMap = jsonDecode(response.body);
        var errorMessage = extractErrorMessage(errorMap);
        showErrorMessage(errorMessage);
      }
      return response;
    } catch (error) {
      log('An error occurred: $error');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }

  //delete method
  Future<http.Response> deleteRequest(String url) async {
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "'Bearer '${localData.read('access_token')}",
        },
      );
      log("Response::::::::${response.body}");
      if (response.statusCode == 401) {
        // refreshToken();
        // Get.offAll(() => LoginView());
        Get.rawSnackbar(
          message: 'Token Expired Please Login Again',
          backgroundColor: Colors.grey.shade600,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode != 204) {
        var errorMap = jsonDecode(response.body);
        var errorMessage = extractErrorMessage(errorMap);
        showErrorMessage(errorMessage);
      }
      return response;
    } catch (error, stackTrace) {
      log('An error occurred: $error');
      log('Stack trace: $stackTrace');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }

  //post request without token

  Future<http.Response> postRequestWithoutToken(
      String url, Map<String, dynamic> body) async {
    try {
      var jsonData = body; // Convert the data to a JSON string
      var response = await http.post(Uri.parse(url),
          body: jsonData); // Use the JSON string as the request body
      log("Response:${response.body}");
      if (response.statusCode >= 400) {
        var errorMap = jsonDecode(response.body);
        var errorMessage = extractErrorMessage(errorMap);
        showErrorMessage(errorMessage);
      }
      return response;
    } catch (error) {
      log('An error occurred: $error');
      rethrow;
    }
  }

  // patch method
  Future<http.Response> patchRequest(
      String url, Map<String, dynamic> body) async {
    try {
      var response = await http.patch(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "'Bearer '${localData.read('access_token')}",

          },
          body: body);
      log("res:${response.body}");

      if (response.statusCode == 401) {
        Get.rawSnackbar(
          message: 'Token Expired Please Login Again',
          backgroundColor: Colors.grey.shade600,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode > 201) {
        var errorMap = jsonDecode(response.body);
        var errorMessage = extractErrorMessage(errorMap);
        showErrorMessage(errorMessage);
      }
      return response;
    } catch (error) {
      log('An error occurred: $error');
      rethrow;
    }
  }

  //method for refreshing token
  // Future<void> refreshToken() async {
  //   var json_body = {
  //     "access": localData.read('access_token'),
  //     "refresh": localData.read('refresh_token')
  //   };
  //   var response =
  //       await http.post(Uri.parse(Constants.BASE_URL + Constants.REFRESH_TOKEN),
  //           headers: {
  //             'x-api-key': Constants.API_KEY,
  //           },
  //           body: json_body);
  //   if (response.statusCode == 200) {
  //     RefreshTokenModel refreshTokenModel =
  //         RefreshTokenModel.fromJson(jsonDecode(response.body));
  //     refreshTokenData.value = refreshTokenModel;
  //     localData.write("access_token", refreshTokenData.value.access);
  //     localData.write("refresh_token", refreshTokenData.value.refresh);
  //   } else {
  //     Get.offAll(LoginView(), transition: Transition.fade);
  //     Get.rawSnackbar(
  //         message: 'Token Expired,Please Login Again',
  //         backgroundColor: AppColors.grey.shade800,
  //         duration: Duration(seconds: 2),
  //         animationDuration: Duration(milliseconds: 100),
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  String extractErrorMessage(dynamic errorMap) {
    if (errorMap is Map<String, dynamic> && errorMap.isNotEmpty) {
      var errorMessage = errorMap.values.first.toString();
      return errorMessage;
    } else {
      return "An error occurred";
    }
  }

  void showErrorMessage(String errorMessage) {
    String errorResponse = errorMessage.replaceAll(RegExp(r'[\[\]]'), '');
    Get.rawSnackbar(
        message: errorResponse,
        backgroundColor: Colors.grey.shade800,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        snackPosition: SnackPosition.BOTTOM);

    log(errorMessage);
  }
}
