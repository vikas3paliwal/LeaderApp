import 'package:Leader/models/task.dart';
import 'package:flutter/foundation.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}
