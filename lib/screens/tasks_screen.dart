import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/Importance_task.dart';
import 'package:Leader/widgets/checked_task_item.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/widgets/task_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task';
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _orderby = false;
  bool _completed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    final customers = Provider.of<Customers>(context);
    final regularTasks =
        tasks.tasks.where((element) => element.customerId == null);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    _orderby
                        ? PopupMenuItem(
                            child: _completed
                                ? Text('Show All Tasks')
                                : Text('Show Completed Tasks'),
                            value: 0,
                          )
                        : null,
                    PopupMenuItem(
                      child: _orderby
                          ? Text('OrderBy Importance')
                          : Text('OrderBy Leads'),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text('Settings'),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text('Logout'),
                      value: 3,
                    )
                  ],
              icon: Icon(Icons.more_vert),
              onSelected: (val) {
                switch (val) {
                  case 0:
                    setState(() {
                      _completed = !_completed;
                    });
                    break;
                  case 1:
                    setState(() {
                      _orderby = !_orderby;
                    });
                    break;
                  default:
                }
              },
              offset: Offset(3, 4)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: tasks.tasks == null
            ? Center(
                child: Text('Nothing to show'),
              )
            : _orderby
                ? ListView.separated(
                    separatorBuilder: (context, index) => Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Divider(
                              height: 1,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                    itemCount: customers.customers.length + 1,
                    itemBuilder: (ctx, i) {
                      if (i < customers.customers.length)
                        return customers.customers.map((e) {
                          if (e.tasks != null) {
                            print(_completed);
                            // if(_completed)
                            final List tasks = customers.completedTasks(
                                e.customerId, _completed);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                (_completed ? tasks.isEmpty : e.tasks.isEmpty)
                                    ? SizedBox(
                                        height: 10,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          addAutomaticKeepAlives: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
                                          ),
                                          itemBuilder: (ctx, i) => _completed
                                              ? tasks.map((e) {
                                                  return GestureDetector(
                                                      onTap: () =>
                                                          pushNewScreen(
                                                            context,
                                                            screen:
                                                                AddTaskScreen(
                                                              taskid: e.taskID,
                                                            ),
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .fade,
                                                            withNavBar: false,
                                                          ),
                                                      child: TaskItem(
                                                        task: e,
                                                        callback: () {
                                                          // setState(() {});
                                                        },
                                                      ));
                                                }).toList()[i]
                                              : e.tasks.map((e) {
                                                  return GestureDetector(
                                                      onTap: () =>
                                                          pushNewScreen(
                                                            context,
                                                            screen:
                                                                AddTaskScreen(
                                                              taskid: e.taskID,
                                                            ),
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .fade,
                                                            withNavBar: false,
                                                          ),
                                                      child: TaskItem(
                                                        task: e,
                                                        callback: () {
                                                          // setState(() {});
                                                        },
                                                      ));
                                                }).toList()[i],
                                          itemCount: _completed
                                              ? tasks.length
                                              : e.tasks.length,
                                        ),
                                      ),
                              ],
                            );
                          }
                        }).toList()[i];
                      else {
                        final List comptasks = regularTasks
                                .where((element) => element.completed == true)
                                .toList() ??
                            [];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Other Tasks",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              (_completed
                                      ? comptasks.isEmpty
                                      : regularTasks.isEmpty)
                                  ? SizedBox(
                                      height: 20,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          crossAxisCount: 2,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: (ctx, ind) {
                                          return _completed
                                              ? comptasks
                                                  .map((e) => GestureDetector(
                                                      onTap: () =>
                                                          pushNewScreen(
                                                            context,
                                                            screen:
                                                                AddTaskScreen(
                                                              taskid: e.taskID,
                                                            ),
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .fade,
                                                            withNavBar: false,
                                                          ),
                                                      child: TaskItem(
                                                        task: e,
                                                        callback: () {
                                                          // setState(() {});
                                                        },
                                                      )))
                                                  .toList()[ind]
                                              : regularTasks
                                                  .map((e) => GestureDetector(
                                                      onTap: () =>
                                                          pushNewScreen(
                                                            context,
                                                            screen:
                                                                AddTaskScreen(
                                                              taskid: e.taskID,
                                                            ),
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .fade,
                                                            withNavBar: false,
                                                          ),
                                                      child: TaskItem(
                                                        task: e,
                                                        callback: () {
                                                          // setState(() {});
                                                        },
                                                      )))
                                                  .toList()[ind];
                                        },
                                        itemCount: _completed
                                            ? comptasks.length
                                            : regularTasks.length,
                                      ),
                                    ),
                            ]);
                      }
                    })
                : ImportantTaskList(),
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
