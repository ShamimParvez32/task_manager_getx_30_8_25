import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class StatusUpdateController extends GetxController {
  bool _statusUpdateInProgress = false;

  bool get statusUpdateInProgress => _statusUpdateInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> statusUpdate (String id, newStatus) async {
    bool isSuccess = false;
    _statusUpdateInProgress = true;
    update();

    final NetworkResponse response =await NetworkCaller.getRequest(url: Urls.taskStatusUpdate( id, newStatus));

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage= null;

    }
    else {
      _errorMessage =response.errorMessage;
    }

    _statusUpdateInProgress=false;
    update();
    return isSuccess;
  }
}
