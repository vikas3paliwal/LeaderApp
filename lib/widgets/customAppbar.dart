import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class CustomAppbar extends PreferredSize {
  CustomAppbar({Widget title})
      : super(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Settings')),
                          PopupMenuItem(child: Text('Logout'))
                        ],
                    icon: Icon(Icons.more_vert),
                    onSelected: null,
                    offset: Offset(3, 4)),
              ],
            ));
}
