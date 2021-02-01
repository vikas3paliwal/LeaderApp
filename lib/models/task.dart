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
}
