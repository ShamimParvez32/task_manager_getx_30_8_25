import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';

class ResetPasswordController extends GetxController{

  bool _resetPasswordInProgress = false;

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;


  Future<bool> resetPassword (String password,) async {
     bool isSuccess=false;
    _resetPasswordInProgress = true;
      update();
      final AuthController _authController =Get.find<AuthController>();
    Map<String, dynamic> requestBody = {
      "email": _authController.getEmail,
      "OTP": _authController.getPinCode,
      "password": password,
    };

     print("Request Body: $requestBody");

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
    );

    if (response.isSuccess) {

      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage=response.errorMessage;
    }

    _resetPasswordInProgress=false;

    update();
    return isSuccess;

  }


}