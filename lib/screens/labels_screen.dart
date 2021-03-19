import 'dart:ui';

import 'package:Leader/providers/labels.dart';
import 'package:Leader/screens/labeled_customers_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:Leader/utilities/http_exception.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:Leader/models/label.dart' as lb;
import 'package:Leader/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LabelScreen extends StatefulWidget {
  static const routeName = '/label';
  final Key key;
  LabelScreen(this.key) : super(key: key);
  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  bool _initial = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_initial) {
      setState(() {
        _isLoading = true;
      });

      final val = Provider.of<Labels>(context);
      Future.value(val.fetchData()).whenComplete(() => setState(() {
            _isLoading = false;
          }));
    }
    _initial = false;
    super.didChangeDependencies();
  }

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
                  labelText: 'Label Name'.tr(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text('Select Color'.tr()),
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
              child: Text('Cancel'.tr())),
          FlatButton(
              onPressed: () async {
                if (_controller.text.trim().isNotEmpty) {
                  final label = lb.Label();
                  label.color = currentColor;
                  label.labelName = _controller.text.toUpperCase();
                  label.labelId = UniqueKey().toString();
                  Provider.of<Labels>(ctx, listen: false).addLabel(label);
                  Navigator.of(context).pop();

                  Map<String, dynamic> data = {
                    'name': label.labelName,
                    'color': label.color.value.toString(),
                  };
                  print(data);

                  try {
                    final ApiResponse response = await ApiHelper().postRequest(
                      'leadgrow/labels/',
                      data,
                    );
                    if (!response.error) {
                      Flushbar(
                        message: 'Message Sent successfully!',
                        duration: Duration(seconds: 3),
                      )..show(context);
                    } else {
                      Flushbar(
                        message: response.errorMessage ?? 'Unable to send',
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }
                  } on HttpException catch (error) {
                    throw HttpException(message: error.toString());
                  } catch (error) {
                    Flushbar(
                      message: 'Unable to send',
                      duration: Duration(seconds: 3),
                    )..show(context);
                  }
                }
                setState(() {
                  _isLoading = false;
                });
              },
              child: Text('Ok'.tr())),
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
        title: Text('Labels'.tr()),
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
      ),
      drawer: SideDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                separatorBuilder: (ctx, i) => Divider(
                  thickness: 2,
                ),
                itemBuilder: (ctx, i) => label.labels
                    .map((e) => Column(children: [
                          Label(
                            customers:
                                e.label == null ? null : e.label.keys.length,
                            labelColor: e.color,
                            labelName: e.labelName,
                            id: e.labelId,
                            customids:
                                e.label == null ? null : e.label.keys.toList(),
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
                'Label'.tr(),
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
