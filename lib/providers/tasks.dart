import 'package:Leader/models/task.dart';
import 'package:flutter/foundation.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  // void addTask(Task task) {
  //   _tasks.add(task);
  //   notifyListeners();
  // }

  void addTask(String taskId, Task task) {
    final index = _tasks.indexWhere((element) => element.taskID == taskId);
    index == -1 ? _tasks.add(task) : _tasks[index] = task;
    notifyListeners();
  }

  void deleteTask(String taskid) {
    _tasks.removeWhere((element) => element.taskID == taskid);
    notifyListeners();
  }

  Task findById(String id) {
    return _tasks.firstWhere((element) => element.taskID == id);
  }
}
