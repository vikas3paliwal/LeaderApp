import 'package:Leader/models/label.dart';
import 'package:flutter/foundation.dart';

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
    notifyListeners();
  }

  Label findById(String id) {
    return _labels.firstWhere((element) => element.labelId == id);
  }
}
