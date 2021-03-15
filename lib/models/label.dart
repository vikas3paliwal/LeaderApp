import 'dart:convert';
import 'dart:ui';

import 'package:Leader/models/customer.dart';
import 'package:flutter/material.dart';

class Label {
  String labelId;
  String labelName;
  Color color;
  List<String> customers;
  Map<String, bool> label;
  Label({
    this.color,
    this.labelName,
    this.label,
    this.labelId,
  });

  Map<String, dynamic> toJson() {
    List<Map> customers = this.customers == null
        ? null
        : this.customers.map((e) => json.decode(e)).toList();
    Map<String, dynamic> data = {
      // 'labelId': labelId,
      'labelName': labelName,
      'color': color,
      'customers': customers,
      'label': label
    };
    return data;
  }

  void fromJson(res) {
    // print(res['color'].runtimeType);
    labelId = res['id'].toString();
    labelName = res['name'];
    color = Color(int.parse(res['color']));
    // print();
    // color = Colors.blue;
  }
}
