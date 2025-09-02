import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/update_profile_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/looder.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/tm_app_bar.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UpdateProfileController _updateProfileController =Get.find<UpdateProfileController>();
  final AuthController _authController =Get.find<AuthController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text = _authController.userModel?.email ?? '';
    _firstNameTEController.text = _authController.userModel?.firstName ?? '';
    _lastNameTEController.text = _authController.userModel?.lastName ?? '';
    _mobileTEController.text = _authController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TmAppBar(fromUpdateProfile: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(36),
            child: _buildForm(textTheme),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 80),
          Text('Update Profile', style: textTheme.titleLarge),
          SizedBox(height: 24),
          _buildPhotoPicker(),
          SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailTEController,
            decoration: InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your Email';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _firstNameTEController,
            decoration: InputDecoration(hintText: 'firstName'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your firstName';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            decoration: InputDecoration(hintText: 'lastName'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your lastName';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _mobileTEController,
            decoration: InputDecoration(hintText: 'Mobile no'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your phone no';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            controller: _passwordTEController,
            decoration: InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your password';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          GetBuilder<UpdateProfileController>(
            builder: (controller) {
              return Visibility(
                visible: controller.updateProfileInProgress== false,
                replacement: CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    _onTabUpdateProfileBtn();
                  },
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GetBuilder<UpdateProfileController>(
      builder: (controller) {
        return GestureDetector(
          onTap: controller.pickImage,

          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: Colors.grey,
                  ),
                  child: const Text('Photo', style: TextStyle(color: Colors.white)),
                  alignment: Alignment.center,
                ),
                SizedBox(width: 8),
                Text(
                  _updateProfileController.pickedImage == null ? 'No item selected' : _updateProfileController.pickedImage!.name,
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _onTabUpdateProfileBtn() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }






  Future<void> _updateProfile() async {
    final isSuccess=await _updateProfileController.updateProfile(
        _emailTEController.text.trim(),
        _firstNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _mobileTEController.text.trim(),
        _passwordTEController.text);

    if (isSuccess) {
      _passwordTEController.clear();
      showSnakeBarMessage(context, 'Profile Updated');
    }
    else {
      showSnakeBarMessage(context, _updateProfileController.errorMessage!);
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _passwordTEController.dispose();
    _mobileTEController.dispose();
  }
}
