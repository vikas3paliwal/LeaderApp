import 'package:flutter/cupertino.dart';

class Business extends ChangeNotifier {
  String address;
  String mobileNo;
  String webaddress;
  String emailaddress;
  String name;
  String id;
  String imgurl;

  Business _business;
  Business({
    this.address,
    this.emailaddress,
    this.id,
    this.imgurl,
    this.mobileNo,
    this.name,
    this.webaddress,
  });
  Business get business {
    return _business;
  }

  void editBusiness({
    String address,
    String emailaddress,
    String id,
    String imgurl,
    String mobileNo,
    String name,
    String webaddress,
  }) {
    _business = Business(
      address: address,
      emailaddress: emailaddress,
      id: _business?.id ?? id,
      imgurl: imgurl,
      mobileNo: mobileNo,
      name: name,
      webaddress: webaddress,
    );

    notifyListeners();
  }
}
