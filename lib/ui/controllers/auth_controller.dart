

import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_getx_30_8_25/data/models/user_model.dart';

class AuthController extends GetxController{

   String? accessToken;
   UserModel? userModel;
   String? _pinCode;
   String? _email;

   static AuthController get to => Get.find();

   String get getPinCode => _pinCode ?? '';
   set setPinCode(String pin) {
    _pinCode = pin;
  }

   String get getEmail => _email?? '';
   set setEmail(String email) {
    _email = email;
  }




  static const String _accessTokenKey='access-token';
  static const String _userDataKey='user-data';


   Future<void> setUserData(String token, UserModel model)async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString(_accessTokenKey, token);
    sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken=token;
    userModel=model;
    update();

  }

   Future<void> getUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? token =sharedPreferences.getString(_accessTokenKey);
    String? userData=sharedPreferences.getString(_userDataKey);
    accessToken =token;
    userModel=UserModel.fromJson(jsonDecode(userData!));
    update();
  }


   Future<bool>isUserLoggedIn()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? token =sharedPreferences.getString(_accessTokenKey);
    if(token !=null){
      getUserData();
      return true;
    }
    return false;
  }

   Future<void> updateUserData(UserModel model) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
     userModel = model;
     update();
   }



  Future<void> clearUserData()async{
   SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
 }
}
