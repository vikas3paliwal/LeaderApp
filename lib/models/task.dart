import 'package:flutter/material.dart';

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
}
