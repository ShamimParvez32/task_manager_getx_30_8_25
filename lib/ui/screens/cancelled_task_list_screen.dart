import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/cancelled_task_list_model.dart';
import 'package:task_manager_getx_30_8_25/data/services/network_caller.dart';
import 'package:task_manager_getx_30_8_25/data/utlis/urls.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/screen_background.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/task_item.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/tm_app_bar.dart';

void main() => runApp(MaterialApp(home: CancelledTaskListScreen()));

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  final CancelledTaskListController _cancelledTaskListController=Get.find<CancelledTaskListController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cancelledNewTaskList();
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
            GetBuilder<CancelledTaskListController>(
              builder: (controller) {
                return Expanded(
                  child:
                        controller.cancelledTaskListInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: controller.cancelledTaskList[index],
                        refreshList: () {
                          _cancelledNewTaskList();
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





  Future<void> _cancelledNewTaskList() async {
    final bool isSuccess= await _cancelledTaskListController.getCancelledTaskList();

    if (! isSuccess) {
      showSnakeBarMessage(context, _cancelledTaskListController.errorMessage!);
    }
  }

}

