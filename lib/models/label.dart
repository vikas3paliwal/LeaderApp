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
}
