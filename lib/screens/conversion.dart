import "package:flutter/material.dart";
import "dart:math";

class ConversionScreen extends StatefulWidget {
  @override
  ConversionScreenState createState() => ConversionScreenState();
}

class ConversionScreenState extends State<ConversionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversion Table"), elevation: 0.0),
      body: Column(
        children: [
          DropdownButtonFormField(value: 'a', items: [
            DropdownMenuItem(
              child: Text('a'),
              value: 'a',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'b',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'c',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'd',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'e',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'f',
            ),
            DropdownMenuItem(
              child: Text('a'),
              value: 'g',
            ),
          ]),
        ],
      ),
    );
  }
}
