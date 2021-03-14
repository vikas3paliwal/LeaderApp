import 'package:Leader/models/task.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ImportantTaskList extends StatelessWidget {
  final List<String> importance = ["Urgent", "Important", "Routine Task"];
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context).tasks;
    return ListView.separated(
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
              final urgentTasks = tasks
                  .where((element) => element.importance == Importance.Urgent)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    importance[i].tr(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  urgentTasks.isEmpty
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (ctx, i) => urgentTasks.map((e) {
                              return GestureDetector(
                                  onTap: () => pushNewScreen(
                                        context,
                                        screen: AddTaskScreen(
                                          taskid: e.taskID,
                                        ),
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                        withNavBar: false,
                                      ),
                                  child: TaskItem(
                                    task: e,
                                  ));
                            }).toList()[i],
                            itemCount: urgentTasks.length,
                          ),
                        ),
                ],
              );
              break;
            case "Important":
              final importantTasks = tasks.where((element) =>
                  element.importance == Importance.ImportantButNotUrgent);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    importance[i].tr(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  importantTasks.isEmpty
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (ctx, i) => importantTasks.map((e) {
                              return GestureDetector(
                                  onTap: () => pushNewScreen(
                                        context,
                                        screen: AddTaskScreen(
                                          taskid: e.taskID,
                                        ),
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                        withNavBar: false,
                                      ),
                                  child: TaskItem(
                                    task: e,
                                  ));
                            }).toList()[i],
                            itemCount: importantTasks.length,
                          ),
                        ),
                ],
              );
              break;
            case "Routine Task":
              final routineTasks = tasks
                  .where(
                      (element) => element.importance == Importance.RoutineTask)
                  .toList();
              print(routineTasks);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    importance[i].tr(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (ctx, i) => routineTasks.map((e) {
                        return GestureDetector(
                            onTap: () => pushNewScreen(
                                  context,
                                  screen: AddTaskScreen(
                                    taskid: e.taskID,
                                  ),
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                  withNavBar: false,
                                ),
                            child: TaskItem(
                              task: e,
                            ));
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
        });
  }
}
