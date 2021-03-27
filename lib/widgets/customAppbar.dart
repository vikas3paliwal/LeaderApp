import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppbar extends PreferredSize {
  Map<String, Widget> appbar = {
    'Leads': AppBar(
      title: Text('LEADS'),
    ),
  };
  CustomAppbar({Widget title, Widget child})
      : super(preferredSize: Size.fromHeight(50), child: child);
}
