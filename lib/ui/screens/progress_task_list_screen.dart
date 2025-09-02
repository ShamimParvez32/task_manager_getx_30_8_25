import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/task_item.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/tm_app_bar.dart';

void main() => runApp(MaterialApp(home: ProgressTaskListScreen()));

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
final ProgressTaskListController _progressTaskListController=Get.find<ProgressTaskListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressNewTaskList();
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
            GetBuilder<ProgressTaskListController>(
              builder: (controller) {
                return Expanded(
                  child:
                  controller.progressTaskListInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.progressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: controller.progressTaskList[index],
                        refreshList: () {
                          _progressNewTaskList();
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



  Future<void> _progressNewTaskList() async {
    final bool isSuccess=await _progressTaskListController.getProgressTaskList();

    if (! isSuccess) {
      showSnakeBarMessage(context, _progressTaskListController.errorMessage!);
    }

  }


}

