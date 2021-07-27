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

  Map<String, dynamic> toJson() {
    Map convert = {
      Importance.Urgent: 'U',
      Importance.ImportantButNotUrgent: 'I',
      Importance.RoutineTask: 'R'
    };

    Map<String, dynamic> data = {
      // 'taskId': taskID,
      // 'day': day.toIso8601String(),
      'time': time.hour.toString() + ':' + time.minute.toString(),
      'customer': customerId,
      'task': task,
      'completed': completed.toString(),
      'importance': convert[importance]
    };
    return data;
  }

  void fromJson(res) {
    // print(res);

    Map convert = {
      'U': Importance.Urgent,
      'I': Importance.ImportantButNotUrgent,
      'R': Importance.RoutineTask
    };

    taskID = res['id'].toString();
    customerId = res['customer'].toString();
    task = res['task'];
    completed = res['completed'];

    String d = res['datetime'];
    var dt = new DateFormat('yyyy-MM-dd HH:mm:ss').parse(d);
    TimeOfDay tm = new TimeOfDay(hour: dt.hour, minute: dt.minute);

    day = dt;
    time = tm;

    importance = convert[res['importance']];
    // print('yyyy');
  }
}
