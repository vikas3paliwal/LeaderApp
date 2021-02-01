import 'dart:ui';

import 'package:Leader/providers/labels.dart';
import 'package:Leader/screens/labeled_customers_screen.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/models/label.dart' as lb;
import 'package:Leader/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LabelScreen extends StatefulWidget {
  static const routeName = '/label';
  final Key key;
  LabelScreen(this.key) : super(key: key);
  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  var currentColor = Colors.black;
  void _addLabel(BuildContext ctx) {
    final _controller = TextEditingController();
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        content: Container(
          height: 310,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Label Name',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text('Select Color'),
              Expanded(
                child: BlockPicker(
                  pickerColor: currentColor,
                  onColorChanged: (val) => setState(() {
                    currentColor = val;
                  }),
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          FlatButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  final label = lb.Label();
                  label.color = currentColor;
                  label.labelName = _controller.text.toUpperCase();
                  label.labelId = UniqueKey().toString();
                  Provider.of<Labels>(ctx, listen: false).addLabel(label);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Ok')),
        ],
      ),
    ).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final label = Provider.of<Labels>(context);
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
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          separatorBuilder: (ctx, i) => Divider(
            thickness: 2,
          ),
          itemBuilder: (ctx, i) => label.labels
              .map((e) => Column(children: [
                    Label(
                      customers: e.label == null ? null : e.label.keys.length,
                      labelColor: e.color,
                      labelName: e.labelName,
                      id: e.labelId,
                    ),
                  ]))
              .toList()[i],
          itemCount: label.labels.length,
        ),
      ),
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _addLabel(context),
        child: Container(
          width: 110,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Label',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(38)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
