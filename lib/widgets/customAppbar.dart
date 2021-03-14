import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppbar extends PreferredSize {
  CustomAppbar({Widget title})
      : super(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Settings'.tr())),
                          PopupMenuItem(child: Text('Log out'.tr()))
                        ],
                    icon: Icon(Icons.more_vert),
                    onSelected: null,
                    offset: Offset(3, 4)),
              ],
            ));
}
