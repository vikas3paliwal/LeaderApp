enum Importance { Urgent, ImportantButNotUrgent, RoutineTask }

class Task {
  DateTime day;
  DateTime time;
  String customerId;
  String task;
  bool completed;
  Importance importance;
  Task(
      {this.customerId,
      this.day,
      this.time,
      this.task,
      this.importance,
      this.completed});
}
