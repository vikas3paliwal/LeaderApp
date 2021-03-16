import 'dart:math';
import 'dart:io';

import 'package:Leader/models/business.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_bottom_sheet.dart';

class EditBusinessDetailsScreen extends StatefulWidget {
  @override
  _EditBusinessDetailsScreenState createState() =>
      _EditBusinessDetailsScreenState();
}

class _EditBusinessDetailsScreenState extends State<EditBusinessDetailsScreen> {
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

  void editBusiness() {
    try {
      if (_formKey.currentState.validate()) {
        Provider.of<Business>(context, listen: false).editBusiness(
            address: addressController.text,
            name: businessNameController.text,
            mobileNo: mobileController.text,
            emailaddress: emailController.text,
            id: UniqueKey().toString(),
            webaddress: webController.text);
        Navigator.of(context).pop();
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
      imageController.text = '';
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
                                              file.toString();
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
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editBusiness(),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Edit'.tr(),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
