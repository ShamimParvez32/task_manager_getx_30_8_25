
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/auth_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/delete_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/forgot_password_verify_email_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/forgot_password_verify_otp_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/sign_in_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/sign_up_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/status_update_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/task_summery_counter_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>SignInController());
    Get.lazyPut(() =>SignUpController());
    Get.put(NewTaskListController());
    Get.put(UpdateProfileController());
    Get.put(AuthController());
    Get.put(TaskSummeryCounterController());
    Get.lazyPut(() =>DeleteController());
    Get.lazyPut(() =>StatusUpdateController());
    Get.lazyPut(() =>ProgressTaskListController());
    Get.lazyPut(() =>ForgotPasswordVerifyOtpController());
    Get.lazyPut(() =>ForgotPasswordVerifyEmailController());
    Get.lazyPut(() =>ResetPasswordController());
    Get.lazyPut(() =>CancelledTaskListController());
    Get.lazyPut(() =>CompletedTaskListController());
    Get.lazyPut(() =>AddNewTaskController());




  }
}


