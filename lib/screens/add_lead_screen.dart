import 'dart:convert';
import 'dart:math';

import 'package:Leader/models/customer.dart';
import 'package:Leader/providers/customers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:Leader/utilities/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AddLeadScreen extends StatefulWidget {
  final Function callback;
  AddLeadScreen(this.callback);
  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController leadNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  DateTime eventDate;
  //focus node contorller
  FocusNode leadNamenode = FocusNode();
  FocusNode locationnode = FocusNode();
  FocusNode mobilenode = FocusNode();
  FocusNode emailnode = FocusNode();
  FocusNode addressnode = FocusNode();
  FocusNode eventnode = FocusNode();

  final Property _property = Property();
  bool _init = true;
  String _prop = '';
  double _propwidth;
  double _leftcontainwidth;
  double _rightcontainwidth;
  double _lowercontainheight;
  double _topleft;
  double _topright;
  double _bottomleft;
  double _bottomright;
  String _custmprop;
  void addLead() async {
    Map<String, dynamic> data;
    try {
      if (_formKey.currentState.validate()) {
        final customer = Provider.of<Customers>(context, listen: false);
        Customer cust = new Customer(
          name: leadNameController.text,
          location: locationController.text,
          phoneNos: mobileController.text,
          emails: emailController.text,
          addresses: addressController.text,
          proptype: _custmprop ?? '',
          pinned: false,
          events: eventDate == null || eventController.text == null
              ? null
              : Event(
                  day: eventDate,
                  eventName: eventController.text,
                ),
        );
        data = cust.toJson();
        try {
          final ApiResponse response = await ApiHelper().postRequest(
            'leadgrow/customer/',
            data,
          );
          if (!response.error) {
            Flushbar(
              message: 'Message Sent successfully!',
              duration: Duration(seconds: 3),
            )..show(context);
            cust.customerId = response.data["id"];
            customer.addLead(cust);
            Navigator.of(context).pop();
          } else {
            Flushbar(
              message: response.errorMessage ??
                  'Unable to add, Please try again later',
              duration: Duration(seconds: 3),
            )..show(context);
          }
        } on HttpException catch (error) {
          throw HttpException(message: error.toString());
        } catch (error) {
          Flushbar(
            message: 'Unable to add, Please try again later',
            duration: Duration(seconds: 3),
          )..show(context);
        }

        print('================');
        print(data);
        print('================');
        // widget.callback();

      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init) {
      _propwidth = MediaQuery.of(context).size.width;
      _leftcontainwidth = _propwidth * 0.4;
      _rightcontainwidth = _propwidth * 0.4;
      _lowercontainheight = 0;
      _topleft = 20;
      _bottomleft = 20;
      _topright = 20;
      _bottomright = 20;
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    mobileController.dispose();
    leadNameController.dispose();
    locationController.dispose();
    addressController.dispose();
    eventController.dispose();
    emailnode.dispose();
    mobilenode.dispose();
    leadNamenode.dispose();
    locationnode.dispose();
    addressnode.dispose();
    eventnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Lead".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
            key: _formKey,
            child: ListView(
              // itemExtent: 40,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: leadNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Lead Name'.tr(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.person,
                        color: Colors.deepOrange[300],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                    ),
                    focusNode: leadNamenode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(locationnode),
                    validator: (value) {
                      if (value.trim().isEmpty)
                        return 'This field can not be empty'.tr();
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: locationController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Location'.tr(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.location_city,
                          color: Colors.deepOrange[300]),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                    ),
                    focusNode: locationnode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(mobilenode),
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return 'This field can\'t be empty';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Mobile No.'.tr(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.call, color: Colors.deepOrange[300]),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                    ),
                    focusNode: mobilenode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(emailnode),
                    validator: (value) {
                      if (value.trim().isEmpty)
                        return 'This field can not be empty'.tr();
                      if (value.length != 10 &&
                          !RegExp(r"^((\+){1}91){1}[1-9]{1}[0-9]{9}$",
                                  multiLine: true)
                              .hasMatch(value))
                        return 'Please enter valid Number'.tr();

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address'.tr(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.email, color: Colors.deepOrange[300]),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                    ),
                    focusNode: emailnode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(addressnode),
                    validator: (value) {
                      if (value.trim().isEmpty)
                        return 'This field can not be empty'.tr();
                      if (!RegExp(
                              r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+([^<>()\.,;:\s@\"]{2,}|[\d\.]+))$',
                              multiLine: true)
                          .hasMatch(value))
                        return 'Please enter valid email address'.tr();
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Address'.tr(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.pin_drop, color: Colors.deepOrange[300]),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          MediaQuery.of(context).size.height * 0.02,
                          20.0,
                          MediaQuery.of(context).size.height * 0.02),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 2)),
                    ),
                    focusNode: addressnode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(eventnode),
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return 'This field can\'t be empty';
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // GestureDetector(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 7),
                      //     child: Icon(
                      //       Icons.add_circle,
                      //       size: 30,
                      //       color: Colors.deepOrange[300],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: TextFormField(
                          controller: eventController,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: 'Event'.tr(),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                                icon: Icon(
                                  Icons.event,
                                  color: Colors.deepOrange[300],
                                ),
                                onPressed: () async {
                                  eventDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1965, 7),
                                      lastDate: DateTime(2101));
                                  print(eventDate);
                                }),
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0,
                                MediaQuery.of(context).size.height * 0.02,
                                20.0,
                                MediaQuery.of(context).size.height * 0.02),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                          ),
                          focusNode: eventnode,
                          validator: (value) {
                            // if (value.trim().isEmpty)
                            //   return 'This field can\'t be empty';
                            if (value.isNotEmpty && eventDate == null) {
                              return 'please select event date'.tr();
                            }
                            return null;
                          },
                          // onSaved: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: _propwidth,
                  height: 60 + _lowercontainheight,
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSize(
                            duration: Duration(milliseconds: 500),
                            vsync: this,
                            curve: Curves.linear,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _rightcontainwidth = 0;
                                  _leftcontainwidth = _propwidth * 0.9;
                                  _lowercontainheight = 70;
                                  _prop = 'Commercial';
                                  _bottomleft = 0;
                                  _bottomright = 0;
                                });
                              },
                              child: Container(
                                width: _leftcontainwidth,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_topleft),
                                    bottomLeft: Radius.circular(_bottomleft),
                                    topRight: Radius.circular(_topright),
                                    bottomRight: Radius.circular(_bottomright),
                                  ),
                                  color: Theme.of(context).accentColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Commercial'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                _prop == 'Commercial' || _prop == 'Residential'
                                    ? 0
                                    : 12,
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _rightcontainwidth = _propwidth * 0.9;
                                  _leftcontainwidth = 0;
                                  _lowercontainheight = 70;
                                  _prop = 'Residential';
                                  _bottomleft = 0;
                                  _bottomright = 0;
                                });
                              },
                              child: Container(
                                height: 60,
                                width: _rightcontainwidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(_topright),
                                    bottomRight: Radius.circular(_bottomright),
                                    topLeft: Radius.circular(_topleft),
                                    bottomLeft: Radius.circular(_bottomleft),
                                  ),
                                  color: Theme.of(context).accentColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Residential'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 3),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        vsync: this,
                        curve: Curves.linear,
                        child: Container(
                          width: _propwidth * 0.9,
                          height: _lowercontainheight,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _prop == 'Commercial'
                                ? [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.commercial['sho'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.all(7),
                                        child: Center(
                                            child: FittedBox(
                                          child: Text(
                                            _property.commercial['sho'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.commercial['sco'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Center(
                                            child: FittedBox(
                                          child: Text(
                                            _property.commercial['sco'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.commercial['scf'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Center(
                                            child: FittedBox(
                                          child: Text(
                                            _property.commercial['scf'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.commercial['other'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Center(
                                            child: FittedBox(
                                          child: Text(
                                            _property.commercial['other'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ]
                                : [
                                    PopupMenuButton(
                                        child: Container(
                                          width: 55,
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Center(
                                              child: Text(
                                            'Plot'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Color(0xff27b86a),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    // Color(0xff27b86a),
                                                    Color(0xfff2380f),
                                                    Colors.deepOrange[300],
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  tileMode: TileMode.mirror),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        itemBuilder: (ctx) => [
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][0]),
                                                  value: 0),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][1]),
                                                  value: 1),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][2]),
                                                  value: 2),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][3]),
                                                  value: 3),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][4]),
                                                  value: 4),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['plot'][5]),
                                                  value: 5),
                                            ],
                                        onSelected: (val) {
                                          setState(() {
                                            switch (val) {
                                              case 0:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][0];
                                                break;
                                              case 1:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][1];
                                                break;
                                              case 2:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][2];
                                                break;
                                              case 3:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][3];
                                                break;
                                              case 4:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][4];
                                                break;
                                              case 5:
                                                _custmprop = 'Plot : ' +
                                                    _property
                                                        .residential['plot'][5];
                                                break;
                                              default:
                                            }
                                          });
                                        }),
                                    PopupMenuButton(
                                        child: Container(
                                          width: 55,
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Center(
                                              child: Text(
                                            'Flat'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Color(0xff27b86a),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    // Color(0xff27b86a),
                                                    Color(0xfff2380f),
                                                    Colors.deepOrange[300],
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  tileMode: TileMode.mirror),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        itemBuilder: (ctx) => [
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][0]),
                                                  value: 0),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][1]),
                                                  value: 1),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][2]),
                                                  value: 2),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][3]),
                                                  value: 3),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][4]),
                                                  value: 4),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][5]),
                                                  value: 5),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][6]),
                                                  value: 6),
                                              PopupMenuItem(
                                                  child: Text(_property
                                                      .residential['Flat'][7]),
                                                  value: 7),
                                            ],
                                        onSelected: (val) {
                                          setState(() {
                                            switch (val) {
                                              case 0:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][0];
                                                break;
                                              case 1:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][1];
                                                break;
                                              case 2:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][2];
                                                break;
                                              case 3:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][3];
                                                break;
                                              case 4:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][4];
                                                break;
                                              case 5:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][5];
                                                break;
                                              case 6:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][6];
                                                break;
                                              case 7:
                                                _custmprop = 'Flat : ' +
                                                    _property
                                                        .residential['Flat'][7];
                                                break;
                                              default:
                                            }
                                          });
                                        }),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.residential['villa'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Center(
                                            child: Text(
                                          _property.residential['villa'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _custmprop =
                                              _property.residential['other'];
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 35,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Center(
                                            child: Text(
                                          _property.residential['other'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff27b86a),
                                            gradient: LinearGradient(
                                                colors: [
                                                  // Color(0xff27b86a),
                                                  Color(0xfff2380f),
                                                  Colors.deepOrange[300],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.mirror),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Property Type'.tr(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 180,
                      height: 40,
                      margin: EdgeInsets.all(7),
                      child: Center(
                          child: Text(
                        _custmprop == null
                            ? ''
                            : _custmprop.split(' ')[0].tr() +
                                    _custmprop.substring(4) ??
                                '',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addLead(),
        label: Text(
          'Add'.tr(),
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        icon: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
