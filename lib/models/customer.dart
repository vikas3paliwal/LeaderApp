import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';

enum PropertyType { Residential, Commercial }

class Customer {
  String customerId;
  String name;
  String company;
  String location;
  List<int> phoneNos = [];
  List<String> emails = [];
  List<String> addresses = [];
  List<Event> events = [];
  List<Label> labels = [];
  List<Task> tasks = [];
  int budget;
  PropertyType type;
  Customer(
      {this.name,
      this.company,
      this.location,
      this.addresses,
      this.budget,
      this.customerId,
      this.emails,
      this.events,
      this.labels,
      this.phoneNos,
      this.tasks,
      this.type});
}

class Event {
  DateTime day;
  String eventName;
  Event({this.day, this.eventName});
}

class Residential {}
