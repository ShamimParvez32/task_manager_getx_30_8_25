import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/sign_in_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/sign_up_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/utlis/app_colors.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/looder.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController =Get.find<SignInController>();

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
                  Text('Get Started with', style: textTheme.titleLarge),
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
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Enter password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  GetBuilder<SignInController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            _onTabSignInBtn();
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
                        TextButton(
                          onPressed: () {
                            Get.toNamed(ForgotPasswordVerifyEmailScreen.name);
                          },
                          child: Text('Forgot Password ?'),
                        ),
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
        text: "Dont have an account ?",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: '  Sign Up',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = () {
              Get.toNamed(SignUpScreen.name);
            },
          ),
        ],
      ),
    );
  }

  void _onTabSignInBtn() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    final bool isSuccess =await _signInController.signIn(_emailTEController.text.trim(), _passwordTEController.text
    );

    if (isSuccess) {
      showSnakeBarMessage(context, 'login Successful');
      Get.offNamed(MainBottomNavScreen.name);
    } else {
      showSnakeBarMessage(context, _signInController.errorMessage!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
