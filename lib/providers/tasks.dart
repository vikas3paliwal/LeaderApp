import 'package:Leader/models/task.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
// import 'package:Leader/widgets/label.dart';
import 'package:flutter/foundation.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(String taskId, Task task) {
    final index = _tasks.indexWhere((element) => element.taskID == taskId);
    index == -1 ? _tasks.add(task) : _tasks[index] = task;
    notifyListeners();
  }

  Future<void> deleteTask(String taskid) async {
    try {
      ApiResponse response = await ApiHelper()
          .deleteRequest(endpoint: 'leadgrow/tasks', id: taskid);
      if (!response.error) {
        _tasks.removeWhere((element) => element.taskID == taskid);
      }
    } catch (e) {
      print(e.toString() + 'line 24');
    }

    notifyListeners();
  }

  List<Task> otherTasks() {
    return _tasks.where((element) => element.customerId == null).toList();
  }

  Task findById(String id) {
    return _tasks.firstWhere((element) => element.taskID == id);
  }

  Future<ApiResponse> fetchData() async {
    ApiResponse response;
    try {
      response = await ApiHelper().getRequest(endpoint: '/leadgrow/tasks');
    } catch (e) {
      print(e);
    }

    _tasks = [];

    // print(response.data);
    for (var res in response.data) {
      print(res);
      Task tsk = new Task();
      tsk.fromJson(res);
      _tasks.add(tsk);
    }
    return response;
    // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  }
}
