import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDislikeCallBack;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;

  const PopupMenu({
    required this.task,
    required this.cancelOrDeleteCallBack,
    required this.likeOrDislikeCallBack,
    required this.editTaskCallBack,
    required this.restoreTaskCallBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return task.isDeleted == false
        ? PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: null,
                    child: TextButton.icon(
                      onPressed: editTaskCallBack,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  PopupMenuItem(
                      onTap: null,
                      child: TextButton.icon(
                        onPressed: likeOrDislikeCallBack,
                        icon: task.isFavorite == false
                            ? const Icon(Icons.bookmark_add_outlined)
                            : const Icon(Icons.bookmark_remove),
                        label: task.isFavorite == false
                            ? const Text('Add to \nbookMarks')
                            : const Text('Remove from \nbookMarks'),
                      )),
                  PopupMenuItem(
                    onTap: null,
                    child: TextButton.icon(
                      onPressed: cancelOrDeleteCallBack,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  )
                ])
        : PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: restoreTaskCallBack,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore'),
                    ),
                    onTap: null,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: cancelOrDeleteCallBack,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever'),
                    ),
                    onTap: null,
                  )
                ]);
  }
}
