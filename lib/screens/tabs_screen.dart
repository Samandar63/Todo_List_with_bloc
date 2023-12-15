import 'package:flutter/material.dart';
import 'package:todo_app_bloc/screens/add_task_screen.dart';
import 'package:todo_app_bloc/screens/completed_tasks_screen.dart';
import 'package:todo_app_bloc/screens/my_drawer.dart';
import 'package:todo_app_bloc/screens/pending_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'PageName': const PendingTasksScreen(), 'title': 'Pendind Tasks'},
    {'PageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
  ];

  var _selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _addTask(BuildContext context) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddTaskScreen(),
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['PageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: "Add Task",
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_sharp),
                label: "Pending Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: "Completed Tasks"),
          ]),
    );
  }
}
