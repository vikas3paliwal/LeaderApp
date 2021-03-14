import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';

import 'package:flutter/material.dart';
import 'package:Leader/widgets/business_card.dart';

class MyBusinessScreen extends StatefulWidget {
  static const routeName = '/business';
  final Key key;
  MyBusinessScreen(this.key) : super(key: key);
  @override
  _MyBusinessScreenState createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromRGBO(109, 109, 109, 1),

        appBar: CustomAppbar(),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BusinessCard(),
              ],
            ),
          ),
        ),
        drawer: SideDrawer());
  }
}
