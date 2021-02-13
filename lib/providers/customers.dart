import 'package:Leader/models/customer.dart';
import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';
import 'package:flutter/widgets.dart';

class Customers with ChangeNotifier {
  // List<int> copyindex = [];
  List<Customer> _customers = [];
  List<Customer> customerscpy = [];
  List<Customer> get customers {
    return [..._customers];
  }

  void addLead(Customer customer) {
    _customers.add(customer);
    notifyListeners();
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
    notifyListeners();
  }

  void onchangedpin(Customer customer) {
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
    notifyListeners();
  }

  void removeCustomer(String id) {
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
  }

  void onSearch(String val) {
    _customers = [];
    customerscpy.forEach((element) {
      if (element.name.toLowerCase().contains(val.toLowerCase()) ||
          element.addresses.toLowerCase().contains(val.toLowerCase()) ||
          element.phoneNos
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()) ||
          element.emails.toLowerCase().contains(val.toLowerCase())) {
        _customers.add(element);
      }
      if (element.labels != null) {
        element.labels.contains(val.toUpperCase());
      }
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
}
