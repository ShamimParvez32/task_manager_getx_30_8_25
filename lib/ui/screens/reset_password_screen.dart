import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/sign_in_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/utlis/app_colors.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/looder.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key,});

  static const String name = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController=Get.find<ResetPasswordController>();

  

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Text('Set password', style: textTheme.titleLarge),
                  SizedBox(height: 8),
                  Text('Minimum length of password should be more than 8 letters', style: textTheme.titleSmall),
                  SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    controller: _newPasswordTEController,
                    decoration: InputDecoration(hintText: 'New Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your new password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(hintText: 'confirm Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'confirm password';
                      }
                      if(value != _newPasswordTEController.text){
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  GetBuilder<ResetPasswordController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.resetPasswordInProgress == false,
                        replacement: CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            _onTabForgotPassBtn();
                          },
                          child: Text('Confirm',style: TextStyle(color: Colors.white),),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 48),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        _buildRichText(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return RichText(
      text: TextSpan(
        text: "Have  account ?",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: '  Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = () {
              Get.offAllNamed(SignInScreen.name);
            },
          ),
        ],
      ),
    );
  }

  void _onTabForgotPassBtn() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
   final  bool isSuccess =await _resetPasswordController.resetPassword(_confirmPasswordTEController.text);

    if (isSuccess) {

      showSnakeBarMessage(context, 'password reset successful');
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
    }
      else{
        showSnakeBarMessage(context, _resetPasswordController.errorMessage!);
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();
  }
}
