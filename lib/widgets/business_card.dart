import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:Leader/models/business.dart';
import 'package:Leader/screens/edit_businessDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share/share.dart';

class BusinessCard extends StatelessWidget {
  final scr = new GlobalKey();
  Future<void> takescrshot(BuildContext context) async {
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
          subject: 'Screenshot + Share',
          text: 'Hey, check it out the sharefiles repo!',
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
    final business = Provider.of<Business>(context).business;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 250,
                  color: Color.fromRGBO(252, 218, 183, 1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HexagonWidget.flat(
                          elevation: 10,
                          color: Color.fromRGBO(53, 53, 53, 1),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(53, 53, 53, 1),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    business?.imgurl ?? '',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //inBounds: false,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          business?.name ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(30, 95, 116, 1),
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 250,
                  color: Color.fromRGBO(30, 95, 116, 1),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    business?.address ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    business?.mobileNo ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.mouse,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    business?.webaddress ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    business?.emailaddress ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
