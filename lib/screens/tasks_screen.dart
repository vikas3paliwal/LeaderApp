import 'package:Leader/widgets/checked_task_item.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/widgets/task_item.dart';

import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task';
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool checked = false;
  bool allchecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Settings')),
                    PopupMenuItem(child: Text('Logout'))
                  ],
              icon: Icon(Icons.more_vert),
              onSelected: null,
              offset: Offset(3, 4)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          children: [
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
            TaskItem(),
          ],
        ),
      ),
      drawer: SideDrawer(),
      floatingActionButton: Container(
        width: 110,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Task',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(38)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
