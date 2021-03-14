import 'dart:convert';
import 'dart:ui';

import 'package:Leader/models/customer.dart';
import 'package:flutter/material.dart';

class Label {
  String labelId;
  String labelName;
  var color;
  List<String> customers;
  Map<String, bool> label;
  Label({
    this.color,
    this.labelName,
    this.label,
    this.labelId,
  });

  Map c = {
    'red': 0xFFFF0000,
    'white': 0xFFFFFFFF,
    'cyan': 0xFF00FFFF,
    'silver': 0xFFC0C0C0,
    'blue': 0xFF0000FF,
    'grey': 0xFF808080,
    'dark_blue': 0xFF0000A0,
    'black': 0xFF000000,
    'light_blue': 0xFFADD8E6,
    'orange': 0xFFFFA500,
    'purple': 0xFF800080,
    'brown': 0xFFA52A2A,
    'yellow': 0xFFFFFF00,
    'maroon': 0xFF800000,
    'lime': 0xFF00FF00,
    'green': 0xFF008000,
    'magenta': 0xFFFF00FF,
    'olive': 0xFF808000,
  };

  Map toJson() {
    List<Map> customers = this.customers == null
        ? null
        : this.customers.map((e) => json.decode(e)).toList();
    return {
      'labelId': labelId,
      'labelName': labelName,
      'color': color,
      'customers': customers,
      'label': label
    };
  }

  void fromJson(res) {
    print(res['color'].runtimeType);
    labelId = res['id'].toString();
    labelName = res['name'];
    color = c[res['color']] != null ? Color(c[res['color']]) : Colors.blue;
    // print();
    // color = Colors.blue;
  }
}
