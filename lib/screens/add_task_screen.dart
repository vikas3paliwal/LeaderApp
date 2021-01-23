import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateFormat format = DateFormat.yMMMd();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Task Description',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 14,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabled: true,
                      filled: true,
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.deepOrange[300],
                        size: 30,
                      )),
                  maxLines: 8,
                ),
                SizedBox(
                  height: 14,
                ),
                Divider(
                  thickness: 3,
                ),
                SizedBox(
                  height: 14,
                ),
                InkWell(
                  onTap: () {},
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabled: true,
                        filled: true,
                        labelText: 'Tap to attatch to lead(Optional)',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        icon: Icon(
                          Icons.person_pin,
                          color: Colors.deepOrange[300],
                          size: 35,
                        )),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Divider(
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.deepOrange[300],
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Set Reminder Date',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 70,
                      padding: EdgeInsets.only(right: 80),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        format.format(date),
                        style: TextStyle(
                            color: Color(0xff383838),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        time.hour.toString() + ' : ' + time.minute.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      var pickedDate = await showRoundedDatePicker(
                          context: context,
                          theme: ThemeData.dark(),
                          imageHeader: AssetImage('assets/images/night.jpg'),
                          height: MediaQuery.of(context).size.height * 0.4,
                          textActionButton: 'Time',
                          onTapActionButton: () async {
                            var pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dial,
                              cancelText: 'CANCEL',
                            );
                            time = pickedTime == null ? time : pickedTime;
                          }).whenComplete(() {
                        setState(() {});
                      });
                      date = pickedDate ?? date;
                    },
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Set Date',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: Text(
            'Add',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
