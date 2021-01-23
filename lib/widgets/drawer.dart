import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Loan Calculator'),
          ),
          ListTile(
            leading: Icon(Icons.tab),
            title: Text('Conversion Table'),
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Upcoming Projects'),
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('News'),
          ),
        ],
      ),
    );
  }
}
