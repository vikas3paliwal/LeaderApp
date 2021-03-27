import 'package:Leader/models/task.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/Importance_task.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/widgets/task_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task';
  final GlobalKey<ScaffoldState> ctx;
  TaskScreen({this.ctx});
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _orderby = false;
  bool _completed = false;
  bool _initial = true;
  bool _isLoading = false;
  final List<String> importance = ["Urgent", "Important", "Routine Task"];
  @override
  void didChangeDependencies() {
    if (_initial) {
      setState(() {
        _isLoading = true;
      });

      final val = Provider.of<Tasks>(context);
      Future.value(val.fetchData()).whenComplete(
        () => setState(
          () {
            _isLoading = false;
          },
        ),
      );
    }
    _initial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    final _tasks = tasks.tasks;
    final customers = Provider.of<Customers>(context);
    // final regularTasks =
    //     tasks.tasks.where((element) => element.customerId == null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'.tr()),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    _orderby
                        ? PopupMenuItem(
                            child: _completed
                                ? Text('Show All Tasks'.tr())
                                : Text('Show Completed Tasks'.tr()),
                            value: 0,
                          )
                        : null,
                    PopupMenuItem(
                      child: _orderby
                          ? Text('GroupBy Importance'.tr())
                          : Text('GroupBy Leads'.tr()),
                      value: 1,
                    ),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                setState(() {
                  _isLoading = true;
                });
                return tasks.fetchData().whenComplete(() {
                  setState(() {
                    _isLoading = false;
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _tasks.isEmpty
                    ? Center(
                        child: Container(
                          height: 230,
                          width: 240,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/no_tasks.png',
                                height: 200,
                                width: 200,
                              ),
                              Text(
                                'No Tasks Yet'.tr(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )
                    : (_orderby
                        ? ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: customers.customers.length + 1,
                            itemBuilder: (ctx, i) {
                              if (i < customers.customers.length) {
                                return customers.customers.map((e) {
                                  if (e.tasks != null) {
                                    print(_completed);
                                    final List tasks = customers.completedTasks(
                                        e.customerId, _completed);
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.name.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        (_completed
                                                ? tasks.isEmpty
                                                : e.tasks.isEmpty)
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                height: 50,
                                                child: Center(
                                                    child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.grey)),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'No Tasks Yet'.tr(),
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                )),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                  itemBuilder: (ctx, i) =>
                                                      _completed
                                                          ? tasks.map((e) {
                                                              return GestureDetector(
                                                                  onTap: () =>
                                                                      pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            AddTaskScreen(
                                                                          taskid:
                                                                              e.taskID,
                                                                        ),
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.fade,
                                                                        withNavBar:
                                                                            false,
                                                                      ),
                                                                  child:
                                                                      TaskItem(
                                                                    task: e,
                                                                    callback:
                                                                        () {
                                                                      setState(
                                                                          () {});
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
                                                                          taskid:
                                                                              e.taskID,
                                                                        ),
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.fade,
                                                                        withNavBar:
                                                                            false,
                                                                      ),
                                                                  child:
                                                                      TaskItem(
                                                                    task: e,
                                                                    callback:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ));
                                                            }).toList()[i],
                                                  itemCount: _completed
                                                      ? tasks.length
                                                      : e.tasks.length,
                                                ),
                                              ),
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
                                    );
                                  } else {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  }
                                }).toList()[i];
                              } else {
                                final List comptasks = tasks
                                        .otherTasks()
                                        .where((element) =>
                                            element.completed == true)
                                        .toList() ??
                                    [];
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Other Tasks".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      (_completed
                                              ? comptasks.isEmpty
                                              : tasks.otherTasks().isEmpty)
                                          ? SizedBox(
                                              height: 20,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
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
                                                          .map((e) =>
                                                              GestureDetector(
                                                                  onTap: () =>
                                                                      pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            AddTaskScreen(
                                                                          taskid:
                                                                              e.taskID,
                                                                        ),
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.fade,
                                                                        withNavBar:
                                                                            false,
                                                                      ),
                                                                  child:
                                                                      TaskItem(
                                                                    task: e,
                                                                    callback:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  )))
                                                          .toList()[ind]
                                                      : tasks
                                                          .otherTasks()
                                                          .map((e) =>
                                                              GestureDetector(
                                                                  onTap: () =>
                                                                      pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            AddTaskScreen(
                                                                          taskid:
                                                                              e.taskID,
                                                                        ),
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.fade,
                                                                        withNavBar:
                                                                            false,
                                                                      ),
                                                                  child:
                                                                      TaskItem(
                                                                    task: e,
                                                                    callback:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  )))
                                                          .toList()[ind];
                                                },
                                                itemCount: _completed
                                                    ? comptasks.length
                                                    : tasks.otherTasks().length,
                                              ),
                                            ),
                                    ]);
                              }
                            })
                        : ListView.separated(
                            physics: AlwaysScrollableScrollPhysics(),
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
                            itemCount: importance.length,
                            itemBuilder: (ctx, i) {
                              switch (importance[i]) {
                                case "Urgent":
                                  final urgentTasks = _tasks
                                      .where((element) =>
                                          element.importance ==
                                          Importance.Urgent)
                                      .toList();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        importance[i].tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      urgentTasks.isEmpty
                                          ? SizedBox(
                                              height: 10,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                itemBuilder: (ctx, i) =>
                                                    urgentTasks.map((e) {
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
                                                            setState(() {});
                                                          }));
                                                }).toList()[i],
                                                itemCount: urgentTasks.length,
                                              ),
                                            ),
                                    ],
                                  );
                                  break;
                                case "Important":
                                  final importantTasks = _tasks.where(
                                      (element) =>
                                          element.importance ==
                                          Importance.ImportantButNotUrgent);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        importance[i].tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      importantTasks.isEmpty
                                          ? SizedBox(
                                              height: 10,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                itemBuilder: (ctx, i) =>
                                                    importantTasks.map((e) {
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
                                                            setState(() {});
                                                          }));
                                                }).toList()[i],
                                                itemCount:
                                                    importantTasks.length,
                                              ),
                                            ),
                                    ],
                                  );
                                  break;
                                case "Routine Task":
                                  final routineTasks = _tasks
                                      .where((element) =>
                                          element.importance ==
                                          Importance.RoutineTask)
                                      .toList();
                                  print(routineTasks);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        importance[i].tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      _isLoading
                                          ? Center(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator())),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                itemBuilder: (ctx, i) =>
                                                    routineTasks.map((e) {
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
                                                            setState(() {
                                                              _isLoading = true;
                                                            });
                                                            Provider.of<Tasks>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .fetchData()
                                                                .then((_) {
                                                              setState(() {
                                                                _isLoading =
                                                                    false;
                                                              });
                                                            });
                                                          }));
                                                }).toList()[i],
                                                itemCount: routineTasks.length,
                                              ),
                                            ),
                                    ],
                                  );
                                  break;
                                default:
                                  return SizedBox();
                              }
                            })),
              ),
            ),
      drawer: SideDrawer(widget.ctx),
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
                'Task'.tr(),
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
