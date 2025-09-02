import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class AddNewTaskController extends GetxController{

  bool _addNewTaskControllerInProgress = false;

  bool get addNewTaskControllerInProgress => _addNewTaskControllerInProgress;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;


  Future<bool> addNewTask (String title,String description,) async {
    bool isSuccess=false;
    _addNewTaskControllerInProgress = true;
      update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addNewTaskUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage=response.errorMessage;
    }

    _addNewTaskControllerInProgress=false;

    update();
    return isSuccess;

  }


}