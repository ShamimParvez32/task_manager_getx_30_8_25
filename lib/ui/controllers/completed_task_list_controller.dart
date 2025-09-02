import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/completed_task_list_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/progress_task_List_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/taskModel.dart';
import 'package:task_manager_getx_30_8_25/data/models/task_list_By_Status_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class CompletedTaskListController extends GetxController {
  bool _completedTaskListInProgress = false;

  bool get completedTaskListInProgress => _completedTaskListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  CompletedTaskListByStatusModel? _completedTaskListByStatusModel;

  List<TaskModel> get completedTaskList => _completedTaskListByStatusModel?.completedTaskModelList?? [];


  Future<bool> getCompletedTaskList () async {
    bool isSuccess = false;
    _completedTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.completedTaskListByStatus('Completed'));


    if (response.isSuccess) {
      _completedTaskListByStatusModel  = CompletedTaskListByStatusModel.fromJson(response.responseBody!);
      isSuccess = true;
      _errorMessage= null;
    }
    else {
      _errorMessage =response.errorMessage;
    }
    _completedTaskListInProgress=false;
    update();
    return isSuccess;
  }
}
