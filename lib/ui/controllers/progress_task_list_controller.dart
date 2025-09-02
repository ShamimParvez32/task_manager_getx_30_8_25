import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/progress_task_List_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/taskModel.dart';
import 'package:task_manager_getx_30_8_25/data/models/task_list_By_Status_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class ProgressTaskListController extends GetxController {
  bool _progressTaskListInProgress = false;

  bool get progressTaskListInProgress => _progressTaskListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  ProgressTaskListByStatusModel? _progressTaskListByStatusModel;

  List<TaskModel> get progressTaskList => _progressTaskListByStatusModel?.progressTaskModelList?? [];


  Future<bool> getProgressTaskList () async {
    bool isSuccess = false;
    _progressTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.progressTaskListByStatus('Progress'));


    if (response.isSuccess) {
      _progressTaskListByStatusModel  = ProgressTaskListByStatusModel.fromJson(response.responseBody!);
      isSuccess = true;
      _errorMessage= null;
    }
    else {
      _errorMessage =response.errorMessage;
    }
    _progressTaskListInProgress=false;
    update();
    return isSuccess;
  }
}
