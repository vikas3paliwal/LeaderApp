import 'package:Leader/models/customer.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';
import 'package:flutter/material.dart';
import 'package:Leader/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Labels(),
        ),
        ChangeNotifierProvider(
          create: (context) => Customers(),
        ),
        // StreamProvider<Labels>(
        //   create: (context) => Stream.value(Labels()),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          buttonColor: Color.fromRGBO(242, 138, 48, 1),
          primaryColor: Color.fromRGBO(89, 87, 117, 1.0),
          accentColor: Color.fromRGBO(84, 103, 143, 1),
          // Color.fromRGBO(171, 166, 191, 1.0),
          canvasColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
