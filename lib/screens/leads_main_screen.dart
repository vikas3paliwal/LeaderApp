import 'package:Leader/providers/budget_provider.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_label_screen.dart';
import 'package:Leader/screens/add_notes_leadscreen.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/screens/selectedCustomers_tasks_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LeadProfileScreen extends StatelessWidget {
  final String customerId;
  LeadProfileScreen(this.customerId);
  bool clicked = false;
  final TextEditingController _budgetcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context).findById(customerId);
    print(customer.toJson());
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
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
                                          itemBuilder: (ctx, i) => customer
                                              .labels
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
                                                            color:
                                                                Colors.white),
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
                              onTap: () => pushNewScreen(context,
                                  screen: AddNotesLeadScreen(
                                    customerId: customerId,
                                    name: customer.name,
                                  ),
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.slideRight,
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
                            Consumer<BudgetProvider>(
                              builder: (ctx, value, child) {
                                print('rebuild');
                                // bool clicked;
                                return Container(
                                  height: clicked ?? false ? 176 : 56,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          if (clicked != null) {
                                            clicked = !clicked;
                                          } else {
                                            clicked = true;
                                          }

                                          value.setState();
                                          // print(context.size.height);
                                        },
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
                                        trailing: clicked
                                            ? Icon(
                                                Icons.arrow_drop_up,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.arrow_drop_down,
                                                size: 30,
                                              ),
                                      ),
                                      clicked ?? false
                                          ? Container(
                                              margin: EdgeInsets.only(top: 8),
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewPadding
                                                      .bottom),
                                              height: 114,
                                              child: Card(
                                                elevation: 7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: TextField(
                                                        controller:
                                                            _budgetcontroller,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]'))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 14.0),
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          if (_budgetcontroller
                                                              .text
                                                              .trim()
                                                              .isNotEmpty) {
                                                            customer.budget =
                                                                _budgetcontroller
                                                                    .text;
                                                            _budgetcontroller
                                                                .clear();
                                                            clicked = !clicked;
                                                            value.setState();
                                                          }
                                                        },
                                                        child: Text('Ok'),
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                );
                              },
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
      ),
    );
  }
}
