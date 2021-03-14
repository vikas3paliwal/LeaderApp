import 'dart:convert';

import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';
import 'package:easy_localization/easy_localization.dart';

class Customer {
  String customerId;
  String name;
  String location;
  String phoneNos;
  String emails;
  String addresses;
  Event events;
  List<Label> labels = [];
  List<Task> tasks = [];
  List<String> notes = [];
  String budget;
  String proptype;
  bool pinned;
  // Property proptype;
  Customer(
      {this.name,
      this.location,
      this.addresses,
      this.customerId,
      this.emails,
      this.events,
      this.labels,
      this.phoneNos,
      this.tasks,
      this.budget,
      this.proptype,
      this.pinned,
      this.notes});
  Map<String, dynamic> toJson() {
    List<Map> labels = this.labels == null
        ? null
        : this.labels.map((e) => e.toJson()).toList();
    List<Map> tasks =
        this.tasks == null ? null : this.tasks.map((e) => e.toJson()).toList();
    Map events = this.events == null
        ? null
        : {
            'day': this.events.day?.toIso8601String() ?? '',
            'eventName': this.events.eventName
          };
    var data = {
      'name': name,
      'location': location,
      'address': addresses,
      'customerId': customerId,
      'email': emails,
      'notes': notes,
      'event': events,
      'labels': labels,
      'tasks': tasks,
      'budget': budget,
      'proptype': proptype,
      'pinned': pinned
    };
    return data;
  }

  void fromJSON(dynamic res) {
    print(res);
    // print(res['mobile'].runtimeType);
    name = res['name'];
    customerId = res['id'].toString();
    location = res['location'];
    emails = res['email'];
    // print(res['event']['day']);
    // print(DateTime('2021-03-07T06:24:03Z'));

    // events = res['event'];
    // labels = res['labels'];
    // tasks = res['taks'];
    // print(res['notes']);
    // notes = res['notes'];
    budget = res['budget'].toString();
    proptype = res['property_type'];
    pinned = res['pinned'];
    phoneNos = res['mobile'];
    addresses = res['address'];

    labels = [];

    for (var x in res['labels']) {
      // print(lbl);
      Label lbl = new Label();
      lbl.fromJson(x);
      // print(lbl.color);
      labels.add(lbl);
    }

    // we
  }
}

class Event {
  DateTime day;
  String eventName;
  Event({this.day, this.eventName});
}

class Property {
  Map<String, dynamic> residential = {
    'plot': [
      '60 sq Yards'.substring(0, 5) + ' ' + '60 sq Yards'.split(' ')[2].tr(),
      '100 sq Yards'.substring(0, 6) + ' ' + '60 sq Yards'.split(' ')[2].tr(),
      '160 sq Yards'.substring(0, 6) + ' ' + '60 sq Yards'.split(' ')[2].tr(),
      '250 sq Yards'.substring(0, 6) + ' ' + '60 sq Yards'.split(' ')[2].tr(),
      '500 sq Yards'.substring(0, 6) + ' ' + '60 sq Yards'.split(' ')[2].tr(),
      '1000 sq Yards'.substring(0, 7) + ' ' + '60 sq Yards'.split(' ')[2].tr()
    ],
    'Flat': [
      'Studio Apartment'.tr(),
      '1 BHK'.tr(),
      '2 BHK'.tr(),
      '2+1 BHK'.tr(),
      '3 BHK'.tr(),
      '3+1 BHK'.tr(),
      '4 BHK'.tr(),
      'Penthouse'.tr()
    ],
    'villa': 'Villa'.tr(),
    'other': 'Other'.tr()
  };
  Map<String, dynamic> commercial = {
    'sho': 'SHO'.tr(),
    'sco': 'SCO'.tr(),
    'scf': 'SCF'.tr(),
    'other': 'Other'.tr()
  };
}
