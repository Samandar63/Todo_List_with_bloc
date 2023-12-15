import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/task.dart';
import 'package:todo_app_bloc/widgets/tasks_list.dart';
import '../blocs/bloc_exports.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});
  static const id = 'tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Column(
          children: [
            Chip(
                label: Text(
                    " ${tasksList.length} Pending | ${state.completedTasks.length} completed")),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
