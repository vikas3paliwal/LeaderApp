import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/add_lead_screen.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/widgets/leads_tile.dart';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

class Leads extends StatefulWidget {
  static const routeName = '/second';
  final Key key;
  Leads(this.key) : super(key: key);
  @override
  _LeadsState createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false;
  bool _search = false;
  bool _showLabels = true;
  bool _orderByDate = true;
  bool _initial = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_initial) {
      setState(() {
        _isLoading = true;
      });

      final val = Provider.of<Customers>(context);
      Future.value(val.fetchData()).whenComplete(() => setState(() {
            _isLoading = false;
          }));
    }
    _initial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<Customers>(context, listen: false);
    // print('11');
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "LEADS".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 70.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1.0),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(1.0, 4.0),
                                blurRadius: 4.0,
                                spreadRadius: -1.0,
                                color: Colors.grey[800]),
                          ]),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.deepOrange[300],
                            ),
                            onPressed: () {
                              // print("your menu action here");
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          _search
                              ? Expanded(
                                  child: TextField(
                                    onChanged: (val) => customers.onSearch(val),
                                    // onSubmitted: (value) =>
                                    //     customers.onSearchCancel(),
                                    decoration: InputDecoration(
                                        hintText: "Search".tr()),
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Text('Search'.tr()),
                                  ),
                                ),
                          IconButton(
                            icon: _search
                                ? Icon(
                                    Icons.close_rounded,
                                    color: Colors.deepOrange[300],
                                  )
                                : Icon(
                                    Icons.search,
                                    color: Colors.deepOrange[300],
                                  ),
                            onPressed: () {
                              setState(() {
                                _search = !_search;
                                if (_search) {
                                  customers.onsearchClick();
                                } else {
                                  customers.onSearchCancel();
                                }
                              });
                            },
                          ),
                          PopupMenuButton(
                            itemBuilder: (ctx) => [
                              PopupMenuItem(
                                  child: Row(
                                children: [
                                  Text('Show Labels'.tr()),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Checkbox(
                                      value: _showLabels,
                                      onChanged: (val) {
                                        setState(() {
                                          _showLabels = val;
                                        });

                                        Navigator.of(ctx).pop();
                                      }),
                                ],
                              )),
                              PopupMenuItem(
                                  child: PopupMenuButton(
                                offset: Offset(15, -105),
                                child: Row(
                                  children: [
                                    Text('List Order'.tr()),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(Icons.arrow_right)
                                  ],
                                ),
                                itemBuilder: (ctxt) => [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Text('Date Added'.tr()),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Checkbox(
                                            value: _orderByDate,
                                            onChanged: (val) {
                                              _orderByDate = val;
                                              Navigator.of(ctxt).pop();
                                              Navigator.of(ctx).pop();
                                            })
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Text('Order By Name'.tr()),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Checkbox(
                                            value: !_orderByDate,
                                            onChanged: (val) {
                                              _orderByDate = !_orderByDate;
                                              Navigator.of(ctxt).pop();
                                              Navigator.of(ctx).pop();
                                            })
                                      ],
                                    ),
                                  )
                                ],
                              ))
                            ],
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.deepOrange[300],
                            ),
                            onSelected: (val) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Customers>(builder: (ctx, val, child) {
                  return Expanded(
                      child: customers.customers.isEmpty
                          ? Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child:
                                    Column(children: [Icon(Icons.person_pin)]),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (ctx, index) => customers.customers
                                  .map((e) => LeadTile(
                                      id: e.customerId,
                                      name: e.name,
                                      labels: e.labels,
                                      showLabels: _showLabels))
                                  .toList()[index],
                              itemCount: customers.customers.length,
                            ));
                }),
        ],
      ),
      drawer: SideDrawer(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: GestureDetector(
        onTap: () {
          pushNewScreen(
            context,
            screen: AddLeadScreen(() {
              // if (listKey.currentState != null)
              // listKey.currentState.insertItem(customers.customers.length,
              //     duration: Duration(milliseconds: 500));
            }),
            pageTransitionAnimation: PageTransitionAnimation.slideRight,
            withNavBar: false,
          );
        },
        child: Container(
          width: 110,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Lead'.tr(),
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
