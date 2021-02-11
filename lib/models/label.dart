import 'dart:convert';
import 'dart:ui';

import 'package:Leader/models/customer.dart';

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
}
