
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx_30_8_25/data/models/taskModel.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/delete_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/controllers/status_update_controller.dart';
import 'package:task_manager_getx_30_8_25/ui/widgets/show_snakebar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.taskModel, required this.refreshList});

  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  final DeleteController _deleteController=Get.find<DeleteController>();
  final StatusUpdateController _statusUpdateController=Get.find<StatusUpdateController>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(widget.taskModel.createdDate ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: Text(
                    widget.taskModel.status ?? 'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(widget.taskModel.status ?? 'New'),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      _deleteTask(widget.taskModel.sId!);
                    }, icon: Icon(Icons.delete_outline),color: Colors.red,),
                    IconButton(
                      onPressed: () {
                        _buildShowDialog(context, textTheme);
                      },
                      icon: Icon(Icons.update_outlined,color: Colors.greenAccent,)
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   _buildShowDialog(BuildContext context, TextTheme textTheme) {
     showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Status', style: textTheme.titleLarge),
          content: Column(
            children: [
              Divider(),
              ListTile(
                title: Text('New', style: textTheme.titleSmall),
                onTap: () {
                  _taskStatusUpdate('New');
                },
              ),
              Divider(),
              ListTile(
                title: Text('Progress', style: textTheme.titleSmall),
                onTap: () {
                  _taskStatusUpdate('Progress');
                },
              ),
              Divider(),
              ListTile(
                title: Text('Completed', style: textTheme.titleSmall),
                onTap: () {
                  _taskStatusUpdate('Completed');
                },
              ),
              Divider(),
              ListTile(
                title: Text('Cancelled', style: textTheme.titleSmall),
                onTap: () {
                  _taskStatusUpdate('Cancelled');

                },
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteTask(String id)async{
    final isSuccess=await _deleteController.deleteTask(id);
   if(isSuccess){
     showSnakeBarMessage(context, 'Delete Successful');
     widget.refreshList();
   }
   else {
     showSnakeBarMessage(context, _deleteController.errorMessage!);
   }

  }

Future<void>_taskStatusUpdate(String newStatus)async{
    final bool isSuccess= await _statusUpdateController.statusUpdate(widget.taskModel.sId!, newStatus);
    if(isSuccess){
      showSnakeBarMessage(context, 'Status Updated to $newStatus');
      widget.refreshList.call();
      Get.back();
    }
    else{showSnakeBarMessage(context, _statusUpdateController.errorMessage!);}
}



  Color _getStatusColor(String status) {
    if (status == 'New') {
      return Colors.blue;
    } else if (status == 'Progress') {
      return Colors.yellow;
    } else if (status == 'Cancelled') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
