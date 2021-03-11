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
    print(res['id'].runtimeType);
    labelId = res['id'].toString();
    labelName = res['name'];
    color = Colors.red;
  }
}
