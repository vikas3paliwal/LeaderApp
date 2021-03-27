import 'package:Leader/models/label.dart';
import 'package:flutter/foundation.dart';
import '../utilities/api_helper.dart';
import '../utilities/api-response.dart';

class Labels with ChangeNotifier {
  List<Label> _labels = [];
  List<Label> get labels {
    return [..._labels];
  }

  void addLabel(Label label) {
    _labels.add(label);
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

  Future<ApiResponse> fetchData() async {
    ApiResponse response;
    try {
      response = await ApiHelper().getRequest(endpoint: '/leadgrow/labels');
    } catch (e) {
      print(e);
    }

    _labels = [];
    if (response != null)
      // print(response.data);
      for (var res in response.data) {
        Label lbl = new Label();
        lbl.fromJson(res);
        // print('y');
        // print(cust.name);
        _labels.add(lbl);
      }
    return response;
  }
}
