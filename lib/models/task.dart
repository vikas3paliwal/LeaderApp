import 'package:flutter/material.dart';

enum Importance { Urgent, ImportantButNotUrgent, RoutineTask }

class Task {
  DateTime day;
  TimeOfDay time;
  String customerId;
  String task;
  bool completed;
  Map<int, Importance> importance;
  Task(
      {this.customerId,
      this.day,
      this.time,
      this.task,
      this.importance,
      this.completed});
}
