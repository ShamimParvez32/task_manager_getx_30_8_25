import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/taskModel.dart';
import 'package:task_manager_getx_30_8_25/data/models/task_list_By_Status_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';

class NewTaskListController extends GetxController {
  bool _newTaskListInProgress = false;

  bool get newTaskListInProgress => _newTaskListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  NewTaskListByStatusModel? _newTaskListByStatusModel;

  List<TaskModel> get newTaskList => _newTaskListByStatusModel?.newTaskModelList?? [];


  Future<bool> getTaskList () async {
    bool isSuccess = false;
    _newTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.newTaskListByStatus('New'));


    if (response.isSuccess) {
      _newTaskListByStatusModel  = NewTaskListByStatusModel.fromJson(response.responseBody!);
      isSuccess = true;
      _errorMessage= null;
    }
    else {
      _errorMessage =response.errorMessage;
    }
    _newTaskListInProgress=false;
    update();
    return isSuccess;
  }
}
