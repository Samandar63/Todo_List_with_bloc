import 'package:flutter/material.dart';
import 'package:todo_app_bloc/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo_app_bloc/screens/recycle_bin.dart';
import 'package:todo_app_bloc/screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                color: Colors.grey,
                child: Text(
                  "Task Drawer",
                  style: Theme.of(context).textTheme.titleSmall,
                )),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text(
                        "${state.pendingTasks.length} | ${state.completedTasks.length}"),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Bin"),
                    trailing: Text("${state.removedTasks.length}"),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                    value: state.swithchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
