import 'package:Leader/widgets/customAppbar.dart';

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
              SizedBox(
                height: 30,
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   child: Card(
              //     elevation: 10,
              //     child: Container(
              //       //width: MediaQuery.of(context).size.width * 0.7,
              //       padding: EdgeInsets.symmetric(vertical: 10),
              //       child: Column(
              //         children: [
              //           ListTile(
              //             dense: true,
              //             leading: Icon(
              //               Icons.note,
              //               color: Colors.deepOrange[300],
              //               size: 25,
              //             ),
              //             title: Text(
              //               'Notes',
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w500),
              //             ),
              //           ),
              //           Divider(
              //             thickness: 1,
              //           ),
              //           ListTile(
              //             dense: true,
              //             leading: Icon(
              //               Icons.event_note,
              //               color: Colors.deepOrange[300],
              //               size: 25,
              //             ),
              //             title: Text(
              //               'Proposals',
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w500),
              //             ),
              //           ),
              //           Divider(
              //             thickness: 1,
              //           ),
              //           ListTile(
              //             dense: true,
              //             leading: Icon(
              //               Icons.bar_chart_rounded,
              //               color: Colors.deepOrange[300],
              //               size: 25,
              //             ),
              //             title: Text(
              //               'Statistics',
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w500),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Loan Calculator'),
            ),
            ListTile(
              leading: Icon(Icons.tab),
              title: Text('Conversion Table'),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Upcoming Projects'),
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('News'),
            ),
          ],
        ),
      ),
    );
  }
}
