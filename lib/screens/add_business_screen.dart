import 'dart:math';
import 'dart:io';
import 'dart:convert';

import 'package:Leader/models/business.dart';
import 'package:Leader/screens/home_screen.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_bottom_sheet.dart';

class AddBusinessDetailsScreen extends StatefulWidget {
  @override
  _AddBusinessDetailsScreenState createState() =>
      _AddBusinessDetailsScreenState();
}

class _AddBusinessDetailsScreenState extends State<AddBusinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _initial = true;
  File _imageFile;
  bool _noImageError = false;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  //focus node contorller

  FocusNode webnode = FocusNode();
  FocusNode mobilenode = FocusNode();
  FocusNode emailnode = FocusNode();
  FocusNode addressnode = FocusNode();

  Future<File> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = File(pickedFile.path);
      _noImageError = false;
    });
    return File(pickedFile.path);

    //cropImage();
  }

  void updateData(data) async {
    try {
      final ApiResponse response = await ApiHelper().postWithFileRequest(
          endpoint: '/leadgrow/business/',
          data: data,
          file: _imageFile,
          fileFieldName: 'image');
      if (!response.error) {
        Flushbar(
          message: 'Message Sent successfully!',
          duration: Duration(seconds: 3),
        )..show(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
          (route) => false,
        );
      } else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to send',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(error.toString());
    } catch (error) {
      Flushbar(
        message: 'Unable to send',
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void editBusiness() {
    try {
      if (_formKey.currentState.validate()) {
        Map<String, dynamic> data = {
          'name': businessNameController.text,
          'email': emailController.text,
          'mobile': "+91" + mobileController.text,
          'address': addressController.text,
          // 'image': base64Image,
          'website': webController.text
        };
        print(data);

        updateData(data);
      }
    } on FormatException catch (e) {
      print('hello');
      print(e.toString());
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_initial) {
      final business = Provider.of<Business>(context).business;
      addressController.text = business?.address ?? '';
      businessNameController.text = business?.name ?? '';
      mobileController.text = business?.mobileNo ?? '';
      webController.text = business?.webaddress ?? '';
      emailController.text = business?.emailaddress ?? '';
      imageController.text = business?.imgurl ?? '';
      print(imageController.text);
    }
    _initial = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    addressController.dispose();
    businessNameController.dispose();
    mobileController.dispose();
    webController.dispose();
    emailController.dispose();

    webnode.dispose();
    mobilenode.dispose();
    emailnode.dispose();
    addressnode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Profile".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: businessNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Business Name'.tr(),
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.business,
                          color: Colors.deepOrange[300],
                        ),
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
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(webnode),
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
                      controller: webController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: 'Website'.tr(),
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.mouse, color: Colors.deepOrange[300]),
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
                      focusNode: webnode,
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
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      decoration: InputDecoration(
                        labelText: 'Contact'.tr(),
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.call, color: Colors.deepOrange[300]),
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
                      focusNode: mobilenode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(emailnode),
                      validator: (value) {
                        if (value.trim().isNotEmpty &&
                            (value.length != 10 &&
                                !RegExp(r"^((\+){1}91){1}[1-9]{1}[0-9]{9}$",
                                        multiLine: true)
                                    .hasMatch(value)))
                          return 'Please enter valid Number'.tr();
                        else
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
                      focusNode: emailnode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(addressnode),
                      validator: (value) {
                        // if (value.trim().isEmpty) return '';
                        if (value.trim().isNotEmpty &&
                            (!RegExp(
                                    r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+([^<>()\.,;:\s@\"]{2,}|[\d\.]+))$',
                                    multiLine: true)
                                .hasMatch(value)))
                          return 'Please enter valid email address'.tr();
                        else
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
                        icon:
                            Icon(Icons.pin_drop, color: Colors.deepOrange[300]),
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
                      focusNode: addressnode,
                      onEditingComplete: () => addressnode.unfocus(),
                      validator: (value) {
                        // if (value.trim().isEmpty)
                        //   return 'This field can\'t be empty';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Add Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print('y');
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Wrap(children: [
                                    ImageBottomSheet(
                                      onTapCamera: () async {
                                        File file =
                                            await getImage(ImageSource.camera);
                                        print(file);
                                        setState(() {
                                          _imageFile = file;
                                          imageController.text =
                                              file.toString();
                                          _noImageError = false;
                                        });
                                        Navigator.pop(context);
                                      },
                                      onTapGallery: () async {
                                        File file =
                                            await getImage(ImageSource.gallery);
                                        setState(() {
                                          _imageFile = file;
                                          imageController.text =
                                              file.path.toString();
                                          _noImageError = false;
                                        });
                                        print(file);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]));
                        },
                      ),
                    ),
                  ),
                  if (_imageFile != null)
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 5.0, color: Theme.of(context).accentColor),
                          image: DecorationImage(
                              image: FileImage(_imageFile),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  if (_imageFile == null)
                    Center(
                      child: Container(
                        // child: Text('dddd'),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 5.0, color: Theme.of(context).accentColor),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageController.text),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editBusiness(),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Add'.tr(),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
