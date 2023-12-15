// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/services/id_generator.dart';
import 'package:todo_app_bloc/widgets/task_tile.dart';
import 'package:todo_app_bloc/model/task.dart';

// ignore: must_be_immutable
class TasksList extends StatelessWidget {
  List<Task> tasksList;

  TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map((task) => ExpansionPanelRadio(
                    value: IdGenerator.ID(),
                    headerBuilder: (context, isOpen) => TaskTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Text\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: task.title,
                        ),
                        const TextSpan(
                            text: '\n\nDescription\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.description)
                      ])),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
