import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectedCustomerTasksScreen extends StatefulWidget {
  final String id;
  final String name;
  SelectedCustomerTasksScreen(this.id, this.name);

  @override
  _SelectedCustomerTasksScreenState createState() =>
      _SelectedCustomerTasksScreenState();
}

class _SelectedCustomerTasksScreenState
    extends State<SelectedCustomerTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context).findById(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name + "'s Tasks"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => pushNewScreen(context,
                          screen: AddTaskScreen(
                            customerid: customer.customerId,
                          ),
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideRight,
                          withNavBar: false)
                      .whenComplete(() {
                    setState(() {});
                  }))
        ],
      ),
      body: customer.tasks == null
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
