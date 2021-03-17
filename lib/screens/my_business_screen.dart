import 'package:Leader/models/business.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';

import 'package:flutter/material.dart';
import 'package:Leader/widgets/business_card.dart';
import 'package:provider/provider.dart';

class MyBusinessScreen extends StatefulWidget {
  static const routeName = '/business';
  final Key key;
  MyBusinessScreen(this.key) : super(key: key);
  @override
  _MyBusinessScreenState createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  bool _initial = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_initial) {
      setState(() {
        _isLoading = true;
      });

      final val = Provider.of<Business>(context);
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
