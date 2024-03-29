import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
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

  // void editBusiness({
  //   String address,
  //   String emailaddress,
  //   String imgurl,
  //   String mobileNo,
  //   String name,
  //   String webaddress,
  // }) {
  //   _business = Business(
  //     address: address,
  //     emailaddress: emailaddress,
  //     id: _business.id,
  //     imgurl: imgurl,
  //     mobileNo: mobileNo,
  //     name: name,
  //     webaddress: webaddress,
  //   );

  //   notifyListeners();
  // }

  Future<ApiResponse> fetchData() async {
    ApiResponse response;
    try {
      response = await ApiHelper().getRequest(endpoint: '/leadgrow/business');
    } catch (e) {
      print(e);
    }

    // _labels = [];
    print('#############');
    print(response.data);
    print('#############');
    if (response.data == []) {
      return null;
    }
    // print('ouy');
    final data = response.data[0];
    // print('**************');
    // Business b = new Business();
    _business.mobileNo = data['mobile'];
    _business.address = data['address'];
    _business.webaddress = data['website'];
    _business.emailaddress = data['email'];
    _business.imgurl = data['image'];
    _business.name = data['name'];
    _business.id = data['id'].toString();
    // _business = b;
    // _business.mobileNo = data['mobile'].toString();

    notifyListeners();
    // print('y');
    return response;
  }
}
