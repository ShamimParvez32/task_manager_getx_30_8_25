import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_getx_30_8_25/data/models/user_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;

  bool get updateProfileInProgress => _updateProfileInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  XFile? _pickedImage;

  XFile? get pickedImage => _pickedImage;


  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
      update();
    }
  }


  Future<bool> updateProfile(String email,
      String firstName,
      String lastName,
      String mobile,
      String password,) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile
    };

    String? base64Photo;
    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      base64Photo = base64Encode(imageBytes);
      requestBody['photo'] = base64Photo;
    }

    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      Map<String, dynamic>? responseData = response.responseBody;
      if (responseData!['status'] == 'success') {
        final updatedData = responseData['data'];

        AuthController authController = Get.find<AuthController>();
        String? token = authController.accessToken;

        if (token != null && authController.userModel != null) {
          UserModel oldUser = authController.userModel!;

          // Merge old + new fields, and inject local photo if selected
          UserModel updateUser = UserModel(
            email: updatedData['email'] ?? email, // take from response or request
            firstName: updatedData['firstName'] ?? firstName,
            lastName: updatedData['lastName'] ?? lastName,
            mobile: updatedData['mobile'] ?? mobile,
            photo: base64Photo ?? updatedData['photo'] ?? oldUser.photo,
          );

          await authController.setUserData(token, updateUser);
        }
      }

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }
}