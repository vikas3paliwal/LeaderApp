import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _maxwidth = 200;
  double _maxheight = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            vsync: this,
            child: Container(
              width: _maxwidth,
              height: _maxheight,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
