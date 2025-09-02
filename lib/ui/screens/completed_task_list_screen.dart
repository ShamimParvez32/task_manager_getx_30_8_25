import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/task_item.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/tm_app_bar.dart';

void main() => runApp(MaterialApp(home: CompletedTaskListScreen()));

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
final CompletedTaskListController _completedTaskListController =Get.find<CompletedTaskListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completedNewTaskList();
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
            SizedBox(height: 8),
            GetBuilder<CompletedTaskListController>(
              builder: (controller) {
                return Expanded(
                  child:
                  controller.completedTaskListInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: controller.completedTaskList[index],
                        refreshList: () {
                          _completedNewTaskList();
                          setState(() {});
                        },);
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }





  Future<void> _completedNewTaskList() async {
    final bool isSuccess= await _completedTaskListController.getCompletedTaskList();
    if (! isSuccess) {
      showSnakeBarMessage(context, _completedTaskListController.errorMessage!);
    }

  }


}

