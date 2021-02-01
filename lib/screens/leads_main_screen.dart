import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_label_screen.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/screens/selectedCustomers_tasks_screen.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LeadProfileScreen extends StatelessWidget {
  final String customerId;
  LeadProfileScreen(this.customerId);
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context).findById(customerId);
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Mark',
        //   style: TextStyle(
        //     fontSize: 25,
        //     color: Colors.white,
        //   ),
        // ),
        //brightness: Brightness.light,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 190.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                            color: Colors.deepOrange[300],
                          )),
                    )
                  ],
                ),
                Positioned(
                  top: 110.0,
                  child: Container(
                    height: 130.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/user.png')),
                        border: Border.all(color: Colors.white, width: 6.0)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.call,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.message,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 156,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.email,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.navigation,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 40,
                  child: Center(
                    child: Text(
                      customer.name,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                    //height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          ListTile(
                            //dense: true,
                            onTap: () => pushNewScreen(
                              context,
                              screen: AddLabelScreen(customerId),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideRight,
                              withNavBar: false,
                            ),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  color: Colors.green[300]),
                              child: Icon(
                                Icons.local_offer,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'ADD LABELS',
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: customer.labels == null ||
                                    customer.labels.isEmpty
                                ? null
                                : Container(
                                    width: 200,
                                    height: 25,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: customer.labels.length,
                                        itemBuilder: (ctx, i) => customer.labels
                                            .map(
                                              (e) => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2.0),
                                                    child: Center(
                                                        child: Text(
                                                      e.labelName,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                  color: e.color),
                                            )
                                            .toList()[i]),
                                  ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          ListTile(
                            //dense: true,
                            onTap: () => pushNewScreen(context,
                                screen: SelectedCustomerTasksScreen(
                                    customerId, customer.name),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                                withNavBar: false),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  color: Colors.red[300]),
                              child: Icon(
                                Icons.notifications_outlined,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'ADD FOLLOW-UP/TASK',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          ListTile(
                            // dense: true,
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  color: Colors.yellow[300]),
                              child: Icon(
                                Icons.book,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'ADD NOTES',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          ListTile(
                            //dense: true,
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  color: Colors.cyan[300]),
                              child: Icon(
                                Icons.attach_money,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'ADD BUDGET',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
