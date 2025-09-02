import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class DeleteController extends GetxController {
  bool _deleteInProgress = false;

  bool get deleteInProgress => _deleteInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> deleteTask (String id) async {
    bool isSuccess = false;
    _deleteInProgress = true;
    update();

    final NetworkResponse response =await NetworkCaller.getRequest(url: Urls.deleteTask(id));

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage= null;

    }
    else {
      _errorMessage =response.errorMessage;
    }

    _deleteInProgress=false;
    update();
    return isSuccess;
  }
}
