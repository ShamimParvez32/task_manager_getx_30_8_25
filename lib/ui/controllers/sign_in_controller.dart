import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/user_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update(); // show loader

    try {
      Map<String, dynamic> requestBody = {"email": email, "password": password};
      final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.signInUrl,
        body: requestBody,
      );

      final AuthController _authController = Get.find<AuthController>();

      if (response.isSuccess && response.responseBody != null) {
        final responseData = response.responseBody!;

        if (responseData.containsKey('token') && responseData.containsKey('data')) {
          String token = responseData['token'];
          UserModel userModel = UserModel.fromJson(responseData['data']);
          await _authController.setUserData(token, userModel);

          isSuccess = true;
          _errorMessage = null;
        } else {
          _errorMessage = responseData['message'] ?? 'Login failed';
        }
      } else {
        if (response.statusCode == 401) {
          _errorMessage = 'Username/password is incorrect';
        } else {
          _errorMessage = response.errorMessage ?? 'Something went wrong';
        }
      }
    } catch (e) {
      _errorMessage = 'Something went wrong: $e';
    } finally {
      _inProgress = false;
      update(); // 🔥 always stop loader
    }

    return isSuccess;
  }


  /*Future<bool> signIn (String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.signInUrl,
      body: requestBody,
    );

    final AuthController _authController =Get.find<AuthController>();

    if (response.isSuccess) {
      String token = response.responseBody!['token'];
      UserModel userModel = UserModel.fromJson(response.responseBody!['data']);
      await _authController.setUserData(token, userModel);
      isSuccess = true;
      _errorMessage= null;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Username/password is incorrect';
      } else {
        _errorMessage =response.errorMessage;
      }
    }
    _inProgress=false;
    update();
    return isSuccess;
  }*/


}
