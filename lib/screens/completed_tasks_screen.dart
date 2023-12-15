import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/task.dart';
import 'package:todo_app_bloc/widgets/tasks_list.dart';
import '../blocs/bloc_exports.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});
  static const id = 'tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;
        return Column(
          children: [
            Chip(label: Text(" ${tasksList.length} Tasks")),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
