import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/sign_in_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/update_profile_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/utlis/app_colors.dart';
class TmAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TmAppBar({
    super.key,  this.fromUpdateProfile=false,
  });
final bool fromUpdateProfile;
  @override
  Widget build(BuildContext context) {
   final  textTheme=Theme.of(context).textTheme;
   final authController =AuthController.to;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: GetBuilder<AuthController>(
        builder: (authController) {
          return Row(
            children: [
                CircleAvatar(
                  backgroundImage: (authController.userModel?.photo != null &&
                      authController.userModel!.photo!.isNotEmpty)
                      ? MemoryImage(base64Decode(authController.userModel!.photo!))
                      : null,
                  child: (authController.userModel?.photo == null || authController.userModel!.photo!.isEmpty)
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                  backgroundColor: Colors.grey,
                  radius: 16,

              ),
              SizedBox(width: 8,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(fromUpdateProfile==false){
                      Get.toNamed(UpdateProfileScreen.name);
                    }
                  },
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(authController.userModel?.fullName?? '',style: textTheme.titleSmall?.copyWith(color: Colors.white)),
                          Text(authController.userModel?.email?? '',style: textTheme.bodySmall?.copyWith(color: Colors.white),)
                        ],


                  ),
                ),
              ),
              IconButton(onPressed: ()async{
                await authController.clearUserData();
                Get.offAllNamed(SignInScreen.name);
              }, icon: Icon(Icons.login_outlined))
            ],
          );
        }
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
