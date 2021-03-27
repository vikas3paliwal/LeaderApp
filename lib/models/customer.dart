import 'dart:convert';

import 'package:Leader/models/label.dart';
import 'package:Leader/models/task.dart';
import 'package:easy_localization/easy_localization.dart';

class Customer {
  String createDate;
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
  DateFormat format = DateFormat.yMMMd();
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
      this.budget = '0',
      this.proptype,
      this.pinned,
      this.notes,
      this.createDate});
  Map<String, dynamic> toJson() {
    List<Map> labels = this.labels == null
        ? null
        : this.labels.map((e) => e.toJson()).toList();
    List<Map> tasks =
        this.tasks == null ? null : this.tasks.map((e) => e.toJson()).toList();
    Map<String, dynamic> data = {
      'name': name,
      'location': location,
      'mobile': "+91" + phoneNos.toString(),
      'email': emails,
      'address': addresses,
      'budget': budget,
      'property_type': proptype,
      'pinned': pinned.toString(),
      'event_name': events?.eventName ?? '',
      'event_date': events?.day == null ? '' : format.format(events?.day) ?? '',
    };
    return data;
  }

  void fromJSON(dynamic res) {
    name = res['name'];
    customerId = res['id'].toString();
    location = res['location'];
    emails = res['email'];

    budget = res['budget'].toString();
    proptype = res['property_type'];
    pinned = res['pinned'];
    phoneNos = res['mobile'];
    addresses = res['address'];
    createDate = res['created_at'];
    notes = [];
    for (var x in res['notes']) {
      notes.add(x);
    }
    labels = [];

    for (var x in res['labels']) {
      // print(lbl);
      Label lbl = new Label();
      lbl.fromJson(x);
      // print(lbl.color);
      labels.add(lbl);
    }

    tasks = [];

    for (var x in res['tasks']) {
      Task tsk = new Task();
      tsk.fromJson(x);
      tasks.add(tsk);
    }
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
