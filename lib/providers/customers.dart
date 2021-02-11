import 'package:Leader/models/customer.dart';
import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';
import 'package:flutter/widgets.dart';

class Customers with ChangeNotifier {
  List<Customer> _customers = [];
  List<Customer> get customers {
    return [..._customers];
  }

  void addLead(Customer customer) {
    _customers.insert(0, customer);
    print(customer.customerId);
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

  void deleteTask(String id) {
    _customers
        .map((e) => e.tasks.removeWhere((element) => element.taskID == id))
        .toList();
    notifyListeners();
  }

  Customer findById(String id) {
    customers.map((e) => print(e.customerId));
    print('line 28');
    print(id);
    return _customers.firstWhere((element) => element.customerId == id);
  }
}
