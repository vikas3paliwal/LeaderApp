import 'package:Leader/models/customer.dart';
import 'package:Leader/models/label.dart';
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

  List<Customer> findByLabel(String id) {
    return _customers
        .where((element) =>
            element.labels
                .firstWhere((element) => element.labelId == id)
                .labelId ==
            id)
        .toList();
  }

  Customer findById(String id) {
    customers.map((e) => print(e.customerId));
    print('line 28');
    print(id);
    return _customers.firstWhere((element) => element.customerId == id);
  }
}
