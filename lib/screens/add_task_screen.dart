import 'package:Leader/models/task.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/all_leads_screen.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:Leader/utilities/http_exception.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTaskScreen extends StatefulWidget {
  // final String customerId;
  final String taskid;
  final String customerid;
  AddTaskScreen({this.taskid, this.customerid});
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateFormat format = DateFormat.yMMMd();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _leadController = TextEditingController();
  String customerId;
  bool _isLoading = false;
  // int _selectedValue;
  Importance _importance;
  bool _error = false;
  @override
  void initState() {
    if (widget.taskid != null) {
      final task =
          Provider.of<Tasks>(context, listen: false).findById(widget.taskid);
      final customer = task.customerId == null
          ? null
          : Provider.of<Customers>(context, listen: false)
              .findById(task.customerId);
      print(customer?.name ?? 'ok');
      _taskController.text = task.task;
      _leadController.text = customer?.name ?? '';
      date = task.day;
      time = task.time;
      _importance = task.importance;
    }
    if (widget.customerid != null) {
      customerId = widget.customerid;
      final customer = widget.customerid == null
          ? null
          : Provider.of<Customers>(context, listen: false)
              .findById(widget.customerid);
      _leadController.text = customer?.name ?? '';
    }

    super.initState();
  }

  Future<String> addCard(BuildContext context, task) async {
    print('adding');
    Map<String, dynamic> data = task.toJson();
    print(data);

    try {
      final ApiResponse response = await ApiHelper()
          .postRequest(
            'leadgrow/tasks/',
            data,
          )
          .whenComplete(() => Navigator.of(context).pop());
      if (!response.error) {
        return response.data["id"].toString();
      } else {}
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.taskid == null ? 'Add Task'.tr() : 'Task'.tr()),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Task Description'.tr(),
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: _taskController,
                  keyboardType: TextInputType.multiline,
                  readOnly: widget.taskid == null ? false : true,
                  decoration: InputDecoration(
                      errorText:
                          _error ? 'This field can not be empty'.tr() : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabled: true,
                      filled: true,
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.deepOrange[300],
                        size: 30,
                      )),
                  maxLines: 5,
                  onChanged: (_) => _error = false,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
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
                TextField(
                  controller: _leadController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabled: true,
                      filled: true,
                      labelText: 'Tap icon to attatch to lead(Optional)'.tr(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      icon: IconButton(
                        icon: Icon(
                          Icons.person_pin,
                        ),
                        onPressed: _leadController.text.isNotEmpty
                            ? null
                            : () {
                                pushNewScreen(context, screen: AllLeadsScreen(
                                        (String name, String id) {
                                  _leadController.text = name;
                                  customerId = id;
                                }),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideRight,
                                    withNavBar: false);
                              },
                        color: Colors.deepOrange[300],
                        iconSize: 35,
                      )),
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
                      widget.taskid == null
                          ? 'Set Reminder Date'.tr()
                          : 'Reminder Date'.tr(),
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
                        format.format(date).split(' ').first.tr() +
                            format.format(date).substring(3),
                        style: TextStyle(
                            color: Color(0xff383838),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        (time.hour.toString().length == 1
                                ? '0' + time.hour.toString()
                                : time.hour.toString()) +
                            ' : ' +
                            (time.minute.toString().length == 1
                                ? '0' + time.minute.toString()
                                : time.minute.toString()),
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
                widget.taskid == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            //height: 5,
                            width: 200,
                            child: Row(
                              children: [
                                PopupMenuButton(
                                  offset: Offset(30, -150),
                                  //initialValue: _selectedValue ?? 2,
                                  itemBuilder: (ctx) => [
                                    PopupMenuItem(
                                      child: Text('Urgent'.tr()),
                                      value: 0,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Important'.tr()),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text('Normal'.tr()),
                                      value: 2,
                                    ),
                                  ],
                                  //initialValue: 0,
                                  icon: Icon(
                                    (Icons.lightbulb_outline),
                                    color: Colors.deepOrange[300],
                                    size: 30,
                                  ),
                                  onSelected: (value) {
                                    if (value != null) {
                                      // _selectedValue = value;
                                      switch (value) {
                                        case 0:
                                          _importance = Importance.Urgent;
                                          break;
                                        case 1:
                                          _importance =
                                              Importance.ImportantButNotUrgent;
                                          break;
                                        case 2:
                                          _importance = Importance.RoutineTask;
                                          break;
                                        default:
                                          print('default');
                                      }
                                    }
                                  },
                                ),
                                FittedBox(
                                  child: Text(
                                    'Set Importance'.tr(),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                var pickedDate = await showRoundedDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    theme: ThemeData.dark(),
                                    imageHeader:
                                        AssetImage('assets/images/night.jpg'),
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    textActionButton: 'Time'.tr(),
                                    onTapActionButton: () async {
                                      var pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        initialEntryMode:
                                            TimePickerEntryMode.dial,
                                        cancelText: 'CANCEL'.tr(),
                                      );
                                      time = pickedTime == null
                                          ? time
                                          : pickedTime;
                                    }).whenComplete(() {
                                  setState(() {});
                                });
                                date = pickedDate ?? date;
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.all(8),
                                child: FittedBox(
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
                                        'Set Date'.tr(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    // color: Theme.of(context).primaryColor,
                                    color: Colors.deepOrange[300],
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        // width: MediaQuery.of(context).size.width * 0.9,
                        // height: 50,
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         width: 2, color: Colors.deepOrange[300])),
                        ),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.taskid == null
            ? _isLoading
                ? CircularProgressIndicator()
                : FloatingActionButton.extended(
                    backgroundColor: Colors.deepOrange[300],
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    label: Text(
                      'Add'.tr(),
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      final task = Provider.of<Tasks>(context, listen: false);
                      setState(() {
                        _isLoading = true;
                      });
                      // final taskid = widget.taskid ?? UniqueKey().toString();

                      final taskmodel = Task(
                          // taskID: taskid,
                          customerId: customerId,
                          day: date,
                          time: time,
                          task: _taskController.text,
                          importance: _importance ?? Importance.RoutineTask,
                          completed: false);
                      print(taskmodel);

                      if (_taskController.text.trim().isNotEmpty) {
                        if (taskmodel.customerId != null) {
                          final customer =
                              Provider.of<Customers>(context, listen: false)
                                  .findById(taskmodel.customerId);

                          customer.tasks == null
                              ? customer.tasks = [taskmodel]
                              : customer.tasks.add(taskmodel);
                        }
                        final id =
                            await addCard(context, taskmodel).whenComplete(() {
                          setState(() {
                            _isLoading = false;
                          });
                        });
                        taskmodel.taskID = id;
                        task.addTask(widget.taskid ?? id, taskmodel);
                      } else {
                        setState(() {
                          _error = true;
                        });
                      }
                    },
                  )
            : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
