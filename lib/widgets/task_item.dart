import 'package:Leader/customs/task_painter.dart';
import 'package:Leader/models/task.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Function callback;
  TaskItem({this.task, this.callback});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.task.completed ? 0.4 : 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(200, 100),
              painter: TaskCustomPainter(),
            ),
            Positioned(
              top: -4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: widget.task.completed
                          ? Icon(
                              Icons.check_box,
                              color: Colors.amber,
                            )
                          : Icon(
                              Icons.check_box_outlined,
                            ),
                      iconSize: 28,
                      color: Color(0xffC7C7C7),
                      onPressed: () {
                        setState(() {
                          widget.task.completed = !widget.task.completed;
                          ApiHelper().getRequest(
                              endpoint:
                                  'leadgrow/tasks/${widget.task.taskID}/complete');
                          print(widget.task.taskID +
                              widget.task.completed.toString());
                          // if (widget.callback != null) widget.callback();
                        });
                      }),
                  SizedBox(
                    width: 60,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.amber,
                      ),
                      iconSize: 28,
                      color: Color(0xffC7C7C7),
                      onPressed: () {
                        Provider.of<Tasks>(context, listen: false)
                            .deleteTask(widget.task.taskID);
                        Provider.of<Customers>(context, listen: false)
                            .deleteTask(widget.task.taskID);
                        widget.callback();
                      }),
                ],
              ),
            ),
            Positioned(
                // top: 10,
                bottom: 0,
                child: Container(
                  height: 30,
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.MMMd().format(widget.task.day),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          (widget.task.time.hour.toString().length == 1
                                  ? '0' + widget.task.time.hour.toString()
                                  : widget.task.time.hour.toString()) +
                              ' : ' +
                              (widget.task.time.minute.toString().length == 1
                                  ? '0' + widget.task.time.minute.toString()
                                  : widget.task.time.minute.toString()),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(17),
                    ),
                    color: Color.fromRGBO(30, 95, 116, 1),
                  ),
                )),
            Positioned(
              top: 58,
              child: Container(
                width: 185,
                height: 94,
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                // color: Colors.pink,
                child: Text(
                  widget.task.task,
                  style: TextStyle(color: Color(0xff3f3f40), fontSize: 16),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // Card(
    //   elevation: 10,
    //   color: Colors.white,
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Container(
    //                 alignment: Alignment.topLeft,
    //                 height: 20,
    //                 color: Color.fromRGBO(30, 95, 116, 1),
    //                 child: Center(
    //                     child: Text(
    //                   "27/12/2020",
    //                   style: TextStyle(color: Colors.white),
    //                 ))),
    //           ),
    //         ],
    //       ),
    //       Flexible(
    //         child: Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Text(
    //             "At 1:30 meeting to attend,2:30 assignment submission",
    //             softWrap: true,
    //             overflow: TextOverflow.fade,
    //             //maxLines: 7,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
