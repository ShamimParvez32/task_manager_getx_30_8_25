import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class SignUpController extends GetxController{

  bool _SignUpInProgress = false;

  bool get signUpInProgress => _SignUpInProgress;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;


  Future<bool> signUp (String email,String firstName,String lastName,String mobile,String password,) async {
    bool isSuccess=false;
    _SignUpInProgress = true;
      update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.signUpUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage=response.errorMessage;
    }

    _SignUpInProgress=false;

    update();
    return isSuccess;

  }


}