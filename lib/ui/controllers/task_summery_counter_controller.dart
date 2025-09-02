import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/count_summery_by_status_model.dart';
import 'package:task_manager_getx_30_8_25/data/models/task_count_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class TaskSummeryCounterController extends GetxController {
  bool _taskSummeryCounterInProgress = false;

  bool get taskSummeryCounterInProgress => _taskSummeryCounterInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  CountTaskSummeryByStatusModel? _countTaskSummeryByStatusModel;

  List<TaskCountModel> get taskCount =>   _countTaskSummeryByStatusModel?.taskCountList?? [];



  Future<bool> getTaskCount () async {
    bool isSuccess = false;
    _taskSummeryCounterInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      _countTaskSummeryByStatusModel =
          CountTaskSummeryByStatusModel.fromJson(response.responseBody!);
      isSuccess=true;
      _errorMessage = null;
    }
    else {
      _errorMessage = response.errorMessage;
    }
    _taskSummeryCounterInProgress=false;
    update();
    return isSuccess;
  }
}
