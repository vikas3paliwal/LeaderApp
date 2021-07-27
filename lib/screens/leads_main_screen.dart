import 'package:Leader/providers/budget_provider.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_label_screen.dart';
import 'package:Leader/screens/add_lead_screen.dart';
import 'package:Leader/screens/add_notes_leadscreen.dart';
import 'package:Leader/screens/add_task_screen.dart';
import 'package:Leader/screens/selectedCustomers_tasks_screen.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> _openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
          title: Text(
            customer.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => pushNewScreen(context,
                    screen: AddLeadScreen(
                      () {},
                      customId: customerId,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation:
                        PageTransitionAnimation.slideRight))
          ],
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
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/leadgrow.jpeg')),
                              color: Colors.black,
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
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 6.0)),
                    ),
                  ),
                  ContactButtons(id: customerId),
                  // Positioned(
                  //   top: 40,
                  //   child: Center(
                  //     child: Text(
                  //       customer.name,
                  //       style: TextStyle(
                  //         fontSize: 30,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                                'ADD LABELS'.tr(),
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
                                'ADD FOLLOW-UP/TASK'.tr(),
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
                                'ADD NOTES'.tr(),
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
                                  height: clicked ?? false ? 176 : 66,
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
                                        subtitle: customer.budget == null
                                            ? null
                                            : Text('${customer.budget}'),
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
                                          'ADD BUDGET'.tr(),
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
                                                        onPressed: () async {
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
                                                            int myint =
                                                                int.tryParse(
                                                                        customer
                                                                            .budget) ??
                                                                    0;
                                                            print(myint);
                                                            // assert(
                                                            //     myint is int);

                                                            ApiResponse
                                                                response =
                                                                await ApiHelper()
                                                                    .patchRequest(
                                                                        'leadgrow/customer/$customerId/',
                                                                        {
                                                                  "budget": myint
                                                                      .toInt()
                                                                      .toString()
                                                                });
                                                            print(
                                                                "response.error");
                                                            print(
                                                                response.data);
                                                          }
                                                        },
                                                        child: Text('Ok'.tr()),
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

class ContactButtons extends StatefulWidget {
  final String id;
  ContactButtons({this.id});
  @override
  _ContactButtonsState createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context).findById(widget.id);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.call,
              size: 35,
              color: Colors.deepOrange[300],
            ),
            onPressed: () {
              print('x');
              setState(() {
                _openUrl('tel:+91${customer.phoneNos}');
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.message,
              size: 35,
              color: Colors.deepOrange[300],
            ),
            onPressed: () {
              print('x');
              setState(() {
                _openUrl('sms:${customer.phoneNos}');
              });
            },
          ),
        ),
        SizedBox(
          width: 136,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.email,
              size: 35,
              color: Colors.deepOrange[300],
            ),
            onPressed: () {
              print('x');
              setState(() {
                _openUrl('mailto:${customer.emails}');
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.navigation,
              size: 35,
              color: Colors.deepOrange[300],
            ),
            onPressed: () {
              print('x');
              setState(() {
                _openUrl(
                    'https://www.google.com/maps/place/${customer.addresses}');
              });
            },
          ),
        ),
      ],
    );
  }
}
