import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  static const routeName = '/first';
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Text('Customers'),
      ),
    );
  }
}
