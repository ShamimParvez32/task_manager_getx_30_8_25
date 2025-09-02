import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';

class ForgotPasswordVerifyOtpController extends GetxController{

  bool _forgotPasswordOtpInProgress = false;

  bool get forgotPasswordOtpInProgress => _forgotPasswordOtpInProgress;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;


  Future<bool> forgotPasswordVerifyOtp (String email, String pinCode,) async {
     bool isSuccess=false;
    _forgotPasswordOtpInProgress = true;
      update();

     final NetworkResponse response = await NetworkCaller.getRequest(
       url: Urls.recoveryOtpUrl(email, pinCode),
     );
     final AuthController _authController =Get.find<AuthController>();

     if (response.isSuccess) {
      _authController.setPinCode = pinCode;
      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage=response.errorMessage;
    }

    _forgotPasswordOtpInProgress=false;

    update();
    return isSuccess;

  }


}