import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/blocs/bloc_exports.dart';
import 'package:todo_app_bloc/model/task.dart';
import 'package:todo_app_bloc/screens/edit_task_screen.dart';
import 'package:todo_app_bloc/widgets/popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted == false
        ? ctx.read<TaskBloc>().add(RemoveTask(task: task))
        : ctx.read<TaskBloc>().add(DeleteTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.favorite_border_outlined)
                    : const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(DateFormat()
                          .add_Hm()
                          .format(DateTime.parse(task.date))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted!
                    ? null
                    : (value) {
                        context.read<TaskBloc>().add(UpdateTask(task: task));
                      },
              ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallBack: () {
                  _removeOrDeleteTask(context, task);
                  Navigator.of(context).pop(context);
                },
                likeOrDislikeCallBack: () {
                  context
                      .read<TaskBloc>()
                      .add(MarkFavoriteOrUnfavoriteTask(task: task));
                  Navigator.of(context).pop(context);
                },
                editTaskCallBack: () {
                  Navigator.of(context).pop(context);
                  _editTask(context);
                },
                restoreTaskCallBack: () {
                  context.read<TaskBloc>().add(RestoreTask(task: task));
                  Navigator.of(context).pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
