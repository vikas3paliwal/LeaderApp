import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SelectedCustomerTasksScreen extends StatelessWidget {
  final String id;
  final String name;
  SelectedCustomerTasksScreen(this.id, this.name);
  @override
  Widget build(BuildContext context) {
    final customer =
        Provider.of<Customers>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(name + "'s Tasks"),
      ),
      body: customer.tasks == null
          ? Text('Nothing here')
          : Padding(
              padding: const EdgeInsets.all(14.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: customer.tasks.length,
                  itemBuilder: (ctx, i) => customer.tasks
                      .map((e) => GestureDetector(
                          onTap: () => pushNewScreen(
                                context,
                                screen: AddTaskScreen(
                                  taskid: e.taskID,
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                                withNavBar: false,
                              ),
                          child: TaskItem(task: e)))
                      .toList()[i]),
            ),
    );
  }
}
