// import 'dart:convert';
import 'dart:io';

import 'package:Leader/models/customer.dart';
import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';
import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import '../utilities/api_helper.dart';
import '../utilities/api-response.dart';

class Customers with ChangeNotifier {
  // List<int> copyindex = [];
  List<Customer> _customers = [];
  List<Customer> customerscpy = [];
  List<Customer> get customers {
    return [..._customers];
  }

  // final String url = "https://www.homeplanify.com/leadgrow/customer";

  void addLead(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  void addContacts(
    List<List<String>> contacts,
  ) async {
    var data = [];
    print(contacts);
    contacts.forEach((element) {
      data.add({"'name'": "'${element[0]}'", "'contact'": "'${element[1]}'"});

      // _customers.add(Customer(name: element[0], phoneNos: element[1]));
    });
    Map<String, dynamic> finaldata = {'customers': data.toString()};
    // print(finaldata);
    try {
      ApiResponse response = await ApiHelper()
          .postRequest('leadgrow/customer/import_customers/', finaldata);
      if (!response.error) {}
    } catch (e) {
      print(e.toString() + 'line 38');
    }
    print(data);
  }

  List<Task> completedTasks(String id, bool status) {
    return _customers
            .firstWhere((element) => element.customerId == id)
            .tasks
            .where((element) => element.completed == true)
            .toList() ??
        [];
  }

  void addLabels(List<Label> labels, String id) {
    var customer = _customers.firstWhere((element) => element.customerId == id);

    if (customer.labels == null) {
      customer.labels = [...labels];
    } else {
      customer.labels.clear();
      customer.labels.addAll(labels);
    }
    String temp = '';
    labels.forEach((element) {
      temp = temp + element.labelId + ',';
    });
    print(temp);
    if (labels != null || labels.isNotEmpty)
      ApiHelper().postRequest(
          'leadgrow/customer/$id/update_customer_label/', {"labels": temp});
    notifyListeners();
  }

  Future<void> onchangedpin(Customer customer) async {
    final index = _customers.indexOf(customer);
    var total = _customers.where((element) => element.pinned == true).length;
    final custom = _customers[index];

    if (customer.pinned == true) {
      _customers.removeAt(index);
      _customers.insert(0, custom);
    } else {
      print(total);
      if (total < _customers.length) {
        _customers.removeAt(index);
        _customers.insert(total, custom);
      }
    }
    ApiHelper()
        .getRequest(endpoint: 'leadgrow/customer/${customer.customerId}/pin');

    notifyListeners();
  }

  void removeCustomer(String id) {
    print(id);
    try {
      ApiHelper().deleteRequest(endpoint: '/leadgrow/customer', id: id);
    } catch (e) {
      print(e.toString() + 'line 71');
    }
    _customers.removeWhere((element) => element.customerId == id);
    customerscpy.removeWhere((element) => element.customerId == id);

    notifyListeners();
  }

  List<Customer> findByLabel(List<String> ids) {
    return _customers
        .where((element) => ids.contains(element.customerId))
        .toList();
  }

  void deleteLabel(String id) {
    _customers
        .map((e) => e.labels.removeWhere((element) => element.labelId == id))
        .toList();
    notifyListeners();
  }

  void onSearch(String val) {
    print(val);
    _customers = [];
    customerscpy.forEach((element) {
      if (element.name.toLowerCase().contains(val.toLowerCase())) {
        _customers.add(element);
      }
      // if (element.labels != null) {
      //   element.labels.contains(val.toUpperCase());
      // }
      // if (element.tasks != null) {
      //   element.tasks.contains(val);
      // }
    });
    notifyListeners();
  }

  void onsearchClick() {
    print(_customers);
    print('inside onsearchclick');
    if (_customers.isNotEmpty) customerscpy = _customers;
  }

  void onSearchCancel() {
    print(_customers);
    print('inside onsearchcancel');
    _customers = customerscpy;
  }

  void deleteTask(String id) {
    _customers
        .map((e) => e.tasks.removeWhere((element) => element.taskID == id))
        .toList();
    notifyListeners();
  }

  Customer findById(String id) {
    customers.map((e) => print(e.customerId));
    return _customers.firstWhere((element) => element.customerId == id);
  }

  Future<String> exportData() async {
    List<List<dynamic>> data = [
      ["Name", "Phone no."]
    ];
    _customers.forEach((element) {
      data.add([
        element.name,
        element.phoneNos,
      ]);
    });
    // print(data);
    final csv = ListToCsvConverter().convert(data);
    print(csv);

    final directory = await getExternalStorageDirectory();

    final path = "${directory.path}/csv-user${DateTime.now()}.csv";
    print(path);
    try {
      final File file = File(path);
      await file.writeAsString(csv);
      return directory.path;
    } catch (e) {
      print(e.toString());
    }
    return directory.path;
  }

  Future<ApiResponse> fetchData([Map<String, String> query]) async {
    ApiResponse response;
    try {
      response = query == null
          ? await ApiHelper().getRequest(endpoint: '/leadgrow/customer')
          : await ApiHelper()
              .getRequest(endpoint: '/leadgrow/customer', query: query);
    } catch (e) {
      print(e);
    }

    _customers = [];

    // print(response.data);
    for (var res in response.data) {
      Customer cust = new Customer();
      cust.fromJSON(res);
      // print('y');
      // print(cust.name);
      _customers.add(cust);
    }
    notifyListeners();
    return response;
  }
}
