import 'package:flutter/material.dart';
import 'package:todo_app_bloc/blocs/bloc_exports.dart';
import 'package:todo_app_bloc/model/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text("title"), border: OutlineInputBorder()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              minLines: 3,
              maxLines: 5,
              autofocus: true,
              controller: descriptionController,
              decoration: const InputDecoration(
                  label: Text("title"), border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        id: oldTask.id,
                        isDone: false,
                        isFavorite: oldTask.isFavorite,
                        date: DateTime.now().toString());

                    context
                        .read<TaskBloc>()
                        .add(EditTask(oldTask: oldTask, newTask: task));
                    Navigator.pop(context);
                  },
                  child: const Text("Save")),
            ],
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
