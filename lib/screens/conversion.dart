import "package:flutter/material.dart";
import "dart:math";

import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

Map<String, double> unitConv = {
  'Are': 1076.0,
  'Sq-yrd': 0.8361,
  'Biswa1': 348480.0,
  'Biswa2': 544499.0,
  'Ground': 2399.9,
  'Hectare': 10000.0,
  'Cent': 40.468,
  'Marla': 5399.2,
  'Guntha': 1088.9,
  'Aankadam': 71.989,
  'Sq-ft': 0.0929,
  'Perch': 272.3,
  'Bigha': 2500.0,
  'Sq-m': 1.0,
  'Kanal': 505.86,
  'Kottah': 66.88,
  'Rood': 10892.0,
  'Acre': 4046.8,
  'Chatak': 449.99,
};

Map<String, double> unitValue = {
  'Are': 0.0,
  'Sq-yrd': 0.0,
  'Biswa1': 0.0,
  'Biswa2': 0.0,
  'Ground': 0.0,
  'Hectare': 0.0,
  'Cent': 0.0,
  'Marla': 0.0,
  'Guntha': 0.0,
  'Aankadam': 0.0,
  'Sq-ft': 0.0,
  'Perch': 0.0,
  'Bigha': 0.0,
  'Sq-m': 0.0,
  'Kanal': 0.0,
  'Kottah': 0.0,
  'Rood': 0.0,
  'Acre': 0.0,
  'Chatak': 0.0,
};

double value = 0.0;
String unit = 'Acre';

void updateValues(double value, String unit) {
  print('=========');
  print(value);
  print(unit);
  print('========');

  for (var x in unitConv.keys) {
    unitValue[x] = (value * unitConv[unit]) / unitConv[x];
  }
}

class ConversionScreen extends StatefulWidget {
  @override
  ConversionScreenState createState() => ConversionScreenState();
}

class ConversionScreenState extends State<ConversionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversion Table".tr()), elevation: 0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Land Unit Conversion".tr(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
                onChanged: (val) {
                  setState(() {
                    value = double.parse(val);
                    updateValues(value, unit);
                  });
                  // print(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DropdownButtonFormField<String>(
                value: unit,
                onChanged: (String newValue) {
                  setState(() {
                    unit = newValue;
                    updateValues(value, unit);
                  });
                  // print(unit);
                },
                items: unitConv.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => unitConv.keys
                      .map((e) => Unit(unit: e, value: unitConv[e]))
                      .toList()[i],
                  itemCount: unitConv.keys.length,
                ),
              ),
            )
            // for (var unit in unitConv.keys)
            //   Unit(unit: unit, value: unitConv[unit]),
            // Unit()
          ],
        ),
      ),
    );
  }
}

// class DropDownList extends StatefulWidget {
//   @override
//   _DropDownListState createState() => _DropDownListState();
// }

// class _DropDownListState extends State<DropDownList> {
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }

class Unit extends StatefulWidget {
  final String unit;
  final double value;
  Unit({this.unit, this.value});
  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.unit.tr()),
              Text(unitValue[widget.unit].toStringAsFixed(3)),
            ],
          ),
        ),
        Divider(height: 5, thickness: 5),
      ],
    );
  }
}
