import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Importance { Urgent, ImportantButNotUrgent, RoutineTask }

class Task {
  String taskID;
  DateTime day;
  TimeOfDay time;
  String customerId;
  String task;
  bool completed;
  Importance importance;

  Task(
      {this.taskID,
      this.customerId,
      this.day,
      this.time,
      this.task,
      this.importance,
      this.completed});
  Map toJson() {
    return {
      'taskId': taskID,
      'day': day.toIso8601String(),
      'time': time.hour.toString() + ' : ' + time.minute.toString(),
      'customerId': customerId,
      'task': task,
      'completed': completed,
      'importance': importance.toString()
    };
  }

  void fromJson(res) {
    print(res);
    taskID = res['id'].toString();
    customerId = res['customer'].toString();
    task = res['task'];
    completed = res['completed'];

    String d = res['datetime'];
    var dt = new DateFormat('MMM dd yyyy HH:mm:ss').parse(d);
    TimeOfDay tm = new TimeOfDay(hour: dt.hour, minute: dt.minute);

    day = dt;
    time = tm;

    importance = Importance.Urgent;
    print('yyyy');
  }
}
