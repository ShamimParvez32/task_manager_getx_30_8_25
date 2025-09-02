import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/sign_in_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/app_logo.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController =Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  void _moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 1));
    bool isUserLoggedIn =await _authController.isUserLoggedIn();
    if(isUserLoggedIn){
      Get.offNamed( MainBottomNavScreen.name);
    }
    else{
      Get.offNamed(SignInScreen.name);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: AppLogo(),)),
    );
  }
}
