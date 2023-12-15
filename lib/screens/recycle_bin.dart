import 'package:flutter/material.dart';
import 'package:todo_app_bloc/blocs/bloc_exports.dart';
import 'package:todo_app_bloc/screens/my_drawer.dart';
import 'package:todo_app_bloc/widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle Bin"),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: null,
                          child: TextButton.icon(
                            onPressed: () {
                              context.read<TaskBloc>().add(DeleteAllTasks());
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete All tasks"),
                          ),
                        )
                      ])
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              Chip(label: Text("${state.removedTasks.length} Tasks")),
              TasksList(tasksList: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}
