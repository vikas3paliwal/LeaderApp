import 'package:Leader/models/label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utilities/api_helper.dart';
import '../utilities/api-response.dart';

class Labels with ChangeNotifier {
  List<Label> _labels = [
    // Label(labelName: 'Online Advertising', color: Colors.black, labelId: '#1'),
    // Label(labelName: 'Telecalling', color: Colors.brown, labelId: '#2'),
    // Label(labelName: 'SMS', color: Colors.yellow, labelId: '#3'),
    // Label(labelName: 'Referral', color: Colors.red, labelId: '#4'),
    // Label(
    //     labelName: 'Newspaper Advertising', color: Colors.green, labelId: '#5'),
    // Label(
    //     labelName: 'Pamphlets Advertising', color: Colors.blue, labelId: '#6'),
  ];
  List<Label> get labels {
    return [..._labels];
  }

  void addLabel(Label label) {
    _labels.add(label);
    notifyListeners();
  }

  void addCustomer(String customerid, List<Label> labels) {
    _labels.map((e) {
      if (e.label != null) {
        if (e.label[customerid] == false) {
          e.label.remove(customerid);
        }
      }
    }).toList();
    notifyListeners();
  }

  void deleteLabel(String id) {
    _labels.removeWhere((element) => element.labelId == id);

    try {
      ApiHelper().deleteRequest(endpoint: '/leadgrow/labels', id: id);
    } catch (e) {
      print(e.toString() + 'line 33');
    }
    notifyListeners();
  }

  void deleteCustomers(String id) {}
  Label findById(String id) {
    return _labels.firstWhere((element) => element.labelId == id);
  }

  List<Label> appLabels() {
    return _labels
        .where((element) =>
            element.labelId == '56' ||
            element.labelId == '57' ||
            element.labelId == '58' ||
            element.labelId == '59' ||
            element.labelId == '60' ||
            element.labelId == '61')
        .toList();
  }

  Future<ApiResponse> fetchData() async {
    ApiResponse response;
    try {
      response = await ApiHelper().getRequest(endpoint: '/leadgrow/labels');
    } catch (e) {
      print(e);
    }

    _labels = [
      // Label(labelName: 'Online Advertising', color: Colors.black, labelId: '1'),
      // Label(labelName: 'Telecalling', color: Colors.brown, labelId: '2'),
      // Label(labelName: 'SMS', color: Colors.yellow, labelId: '3'),
      // Label(labelName: 'Referral', color: Colors.red, labelId: '4'),
      // Label(
      //     labelName: 'Newspaper Advertising',
      //     color: Colors.green,
      //     labelId: '5'),
      // Label(
      //     labelName: 'Pamphlets Advertising', color: Colors.blue, labelId: '6'),
    ];
    if (response != null)
      // print(response.data);
      for (var res in response.data) {
        Label lbl = new Label();
        lbl.fromJson(res);
        // print('y');
        // print(cust.name);
        _labels.add(lbl);
        print('name: ' + lbl.labelName + 'id: ' + lbl.labelId.toString());
      }
    notifyListeners();
    return response;
  }
}
