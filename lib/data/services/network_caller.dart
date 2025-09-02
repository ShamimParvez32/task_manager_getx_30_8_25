import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:task_manager_getx_30_8_25/app.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final bool isSuccess;
  final Map<String, dynamic>? responseBody;
  final int statusCode;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseBody,
    this.errorMessage = 'Something went wrong'
  });
}



class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    final AuthController authController =Get.find<AuthController>();
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL=> $url');

      Response response = await get(uri,
          headers: {'token':authController.accessToken?? ''}
      );
      debugPrint('Response Code=> ${response.statusCode}.');
      debugPrint('Response data=> ${response.body}');
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true,
            statusCode: response.statusCode,
            responseBody: decodedResponse);
      }
      else if(response.statusCode == 401){
        _logout();
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode);
      }
      else{
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode);
      }

    }
    catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1,
        errorMessage: e.toString()
      );
    }
  }
  static Future<NetworkResponse> postRequest({required String url,Map<String,dynamic>? body,bool isLogin=false}) async {
    final AuthController authController =Get.find<AuthController>();

    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL=> $url');
      Response response = await post(uri,
        headers: {'content-type': 'application/json', 'token':isLogin ? '': authController.accessToken?? ''},
        body: jsonEncode(body)
      );
      debugPrint('Response Code=> ${response.statusCode}.');
      debugPrint('Response data=> ${response.body}');
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true,
            statusCode: response.statusCode,
            responseBody: decodedResponse);
      }
      else if(response.statusCode == 401){
        _logout();
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode);
      }
      else{
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode);
      }

    }
    catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1,
          errorMessage: e.toString()
      );
    }
  }

  static Future<void> _logout()async{
    final AuthController authController =Get.find<AuthController>();
    await authController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, SignInScreen.name, (_)=> false);
  }
}