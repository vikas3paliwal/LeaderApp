import 'dart:ui';

import 'package:Leader/providers/budget_provider.dart';
import 'package:Leader/providers/labels.dart';
import 'package:Leader/screens/labeled_customers_screen.dart';
import 'package:Leader/widgets/app_label.dart';
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
  final GlobalKey<ScaffoldState> ctx;

  LabelScreen(this.key, {this.ctx}) : super(key: key);
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
                  // setState(() {
                  //   _isLoading = true;
                  // });
                  final label = lb.Label();
                  label.color = currentColor;
                  label.labelName = _controller.text.toUpperCase();

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
                        message: 'Added successfully!',
                        duration: Duration(seconds: 3),
                      )..show(ctx);
                      label.labelId = response.data["id"].toString();
                      Provider.of<Labels>(ctx, listen: false).addLabel(label);
                      Provider.of<Labels>(ctx, listen: false).fetchData();
                      print('line 107');
                      print(response.data);
                    } else {
                      print('obj');
                      print(response.data);

                      Flushbar(
                        message: response.errorMessage ??
                            'Unable to add, Please try again later',
                        duration: Duration(seconds: 3),
                      )..show(ctx);
                    }
                  } on HttpException catch (error) {
                    throw HttpException(message: error.toString());
                  } catch (error) {
                    print(error.toString());
                    Flushbar(
                      message: 'Unable to add, Please try again later',
                      duration: Duration(seconds: 3),
                    )..show(ctx);
                  }
                }
                // setState(() {
                //   _isLoading = false;
                // });
              },
              child: Text('Ok'.tr())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
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
      drawer: SideDrawer(widget.ctx),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<Labels>(
              builder: (ctx, label, _) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('App Labels'),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (ctx, i) => Divider(
                              thickness: 2,
                            ),
                            itemBuilder: (ctx, i) {
                              return label
                                  .appLabels()
                                  .map((e) => Column(children: [
                                        AppLabel(
                                          labelColor: e.color,
                                          labelName: e.labelName,
                                          id: e.labelId,
                                          custmcount: e.customcounts,
                                          customids: e.customers,
                                        ),
                                      ]))
                                  .toList()[i];
                            },
                            itemCount: label.appLabels().length,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('User Labels'),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (ctx, i) => Divider(
                              thickness: 2,
                            ),
                            itemBuilder: (ctx, i) {
                              print(label.labels.length);
                              return label.labels.map((e) {
                                if (e.labelId != '56' &&
                                    e.labelId != '57' &&
                                    e.labelId != '58' &&
                                    e.labelId != '59' &&
                                    e.labelId != '60' &&
                                    e.labelId != '61') {
                                  return Column(children: [
                                    Label(
                                      ctx: context,
                                      labelColor: e.color,
                                      labelName: e.labelName,
                                      id: e.labelId,
                                      custmcount: e.customcounts,
                                      customids: e.customers,
                                    ),
                                  ]);
                                } else {
                                  return Container();
                                }
                              }).toList()[i];
                            },
                            itemCount: label.labels.length - 5,
                          ),
                        ),
                      ]),
                ),
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
