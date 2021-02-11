import 'package:flutter/cupertino.dart';

class BudgetProvider extends ChangeNotifier {
  void setState() {
    notifyListeners();
  }
}
