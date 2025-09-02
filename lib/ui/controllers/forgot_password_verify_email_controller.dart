import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';

class ForgotPasswordVerifyEmailController extends GetxController{

  bool _forgotPasswordEmailInProgress = false;

  bool get forgotPasswordEmailInProgress => _forgotPasswordEmailInProgress;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;


  Future<bool> forgotPasswordVerifyEmail (String email,) async {
     bool isSuccess=false;
    _forgotPasswordEmailInProgress = true;
      update();

     final NetworkResponse response = await NetworkCaller.getRequest(
       url: Urls.recoveryMailUrl(email),
     );

     final AuthController _authController =Get.find<AuthController>();

    if (response.isSuccess) {
      _authController.setEmail=email;
      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage=response.errorMessage;
    }

    _forgotPasswordEmailInProgress=false;

    update();
    return isSuccess;

  }


}