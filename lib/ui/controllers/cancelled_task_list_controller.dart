import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/cancelled_task_list_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/completed_task_list_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/taskModel.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class CancelledTaskListController extends GetxController {
  bool _cancelledTaskListInProgress = false;

  bool get cancelledTaskListInProgress => _cancelledTaskListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  CancelledTaskListByStatusModel? _cancelledTaskListByStatusModel;

  List<TaskModel> get cancelledTaskList => _cancelledTaskListByStatusModel?.cancelledTaskModelList?? [];


  Future<bool> getCancelledTaskList () async {
    bool isSuccess = false;
    _cancelledTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.cancelledTaskListByStatus('Cancelled'));


    if (response.isSuccess) {
      _cancelledTaskListByStatusModel  = CancelledTaskListByStatusModel.fromJson(response.responseBody!);
      isSuccess = true;
      _errorMessage= null;
    }
    else {
      _errorMessage =response.errorMessage;
    }
    _cancelledTaskListInProgress=false;
    update();
    return isSuccess;
  }
}
