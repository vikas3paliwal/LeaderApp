import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/checked_task_item.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/widgets/task_item.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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
    final tasks = Provider.of<Tasks>(context);
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
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (ctx, i) =>
              tasks.tasks.map((e) => TaskItem(e)).toList()[i],
          itemCount: tasks.tasks.length,
        ),
      ),
      drawer: SideDrawer(),
      floatingActionButton: InkWell(
        onTap: () {
          pushNewScreen(context,
              screen: AddTaskScreen(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
              withNavBar: false);
        },
        child: Container(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
