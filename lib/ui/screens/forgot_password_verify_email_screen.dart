import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/recovery_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/forgot_password_verify_email_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/utlis/app_colors.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/looder.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';
  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordVerifyEmailController _forgotPasswordVerifyEmailController=Get.find<ForgotPasswordVerifyEmailController>();


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
                  Text('Your email address', style: textTheme.titleLarge),
                  SizedBox(height: 8),
                  Text('A 6 digits of OTP will be sent to your email address', style: textTheme.titleSmall),
                  SizedBox(height: 24),
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
                  SizedBox(height: 24),
                  GetBuilder<ForgotPasswordVerifyEmailController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.forgotPasswordEmailInProgress == false,
                        replacement: CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            _onTabForgotPassBtn();
                          },
                          child: Icon(Icons.arrow_circle_right_outlined),
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onTabForgotPassBtn() {
    if (_formKey.currentState!.validate()) {
      _recoveryEmail();
    }
  }



  Future<void> _recoveryEmail() async {
      final bool isSuccess = await _forgotPasswordVerifyEmailController.forgotPasswordVerifyEmail(_emailTEController.text.trim());


    if (isSuccess) {
      showSnakeBarMessage(context, 'Email verification successful');
      Get.toNamed(ForgotPasswordVerifyOtpScreen.name);
    } else {
      showSnakeBarMessage(context, _forgotPasswordVerifyEmailController.errorMessage!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
}
