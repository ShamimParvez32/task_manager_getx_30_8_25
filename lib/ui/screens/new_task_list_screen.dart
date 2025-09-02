import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/task_count_model.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/task_summery_counter_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/task_item.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/tm_app_bar.dart';

void main() => runApp(MaterialApp(home: NewTaskListScreen()));

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  final NewTaskListController _newTaskListController=Get.find<NewTaskListController>();
  final TaskSummeryCounterController _taskSummeryCounterController= Get.find<TaskSummeryCounterController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: TmAppBar(),
      body: ScreenBackground(
        child: Column(
          children: [
            GetBuilder<TaskSummeryCounterController>(
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    height: 80,
                    width: double.maxFinite,
                    child: controller.taskSummeryCounterInProgress
                        ? Center(child: CircularProgressIndicator()) // Center loader for task count
                        : _buildTaskCountSummery(textTheme,controller.taskCount),
                  ),
                );
              }
            ),

            SizedBox(height: 8),

            GetBuilder<NewTaskListController>(
              builder: (controller) {
                return Expanded(
                  child:
                      controller.newTaskListInProgress
                      ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: controller.newTaskList[index],
                        refreshList: () {
                          _getTaskCountByStatus();
                          _getNewTaskList();
                        },);
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final result = await Get.toNamed(AddNewTaskScreen.name);
        if (result != null) {
          _getTaskCountByStatus();
          _getNewTaskList();
        }
      }, child: Icon(Icons.add),),
    );
  }

  Widget _buildTaskCountSummery(TextTheme textTheme , List<TaskCountModel> countList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: countList.length,
      itemBuilder: (BuildContext context, int index) {
        final TaskCountModel model = countList[index];
        return Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.sum.toString(), style: textTheme.titleLarge),
                Text(model.sId ?? '', style: textTheme.titleSmall),

              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _getTaskCountByStatus() async {
    final bool isSuccess = await _taskSummeryCounterController.getTaskCount();

    if ( ! isSuccess) {
      showSnakeBarMessage(context, _taskSummeryCounterController.errorMessage!);
    }

  }


  Future<void> _getNewTaskList() async {
    final bool isSuccess= await _newTaskListController.getTaskList();

    if (! isSuccess) {
    showSnakeBarMessage(context, _newTaskListController.errorMessage!);
    }

  }


}

