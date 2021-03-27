import 'dart:io';
import 'dart:ui';

import 'package:Leader/models/business.dart';
import 'package:Leader/screens/edit_businessDetails_screen.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';

import 'package:flutter/material.dart';
import 'package:Leader/widgets/business_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:easy_localization/easy_localization.dart';

class MyBusinessScreen extends StatefulWidget {
  static const routeName = '/business';
  final GlobalKey<ScaffoldState> ctx;

  final Key key;
  MyBusinessScreen(this.key, {this.ctx}) : super(key: key);
  @override
  _MyBusinessScreenState createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  bool _initial = true;
  bool _isLoading = false;
  final scr = new GlobalKey();

  @override
  void didChangeDependencies() {
    if (_initial) {
      setState(() {
        _isLoading = true;
      });

      final val = Provider.of<Business>(context);
      Future.value(val.fetchData()).whenComplete(() {
        print('yyyyyyyyyyyyyyyyyyy');
        setState(
          () {
            _isLoading = false;
          },
        );
        if (val.business == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => EditBusinessDetailsScreen()),
              (route) => false);
        }
      });
    }
    _initial = false;
    super.didChangeDependencies();
  }

  Future<void> takescrshot(BuildContext context) async {
    final business = Provider.of<Business>(context, listen: false).business;
    try {
      RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
      final directory = (await getExternalStorageDirectory()).path;
      var image = await boundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject();

      Share.shareFiles(['$directory/screenshot.png'],
          subject: 'Business Card',
          text:
              '${business.name}\nAddress: ${business.address}\nContact No: ${business.mobileNo}\nWebsite: ${business.webaddress}\nEmail: ${business.emailaddress}',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      print(pngBytes);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    } catch (e) {
      print('another error' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromRGBO(109, 109, 109, 1),

        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RepaintBoundary(key: scr, child: BusinessCard()),
                Container(
                  height: 60,

                  //width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(75, 93, 103, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () => pushNewScreen(context,
                              screen: EditBusinessDetailsScreen(),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                              withNavBar: false),
                          splashColor: Colors.deepOrange[300],
                          child: Container(
                            child: Center(
                                child: Text(
                              "EDIT DETAILS".tr(),
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 6,
                        thickness: 1.5,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () => takescrshot(context),
                          child: Container(
                            child: Center(
                                child: Text(
                              "SEND BUSINESS CARD".tr(),
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: SideDrawer(widget.ctx));
  }
}
