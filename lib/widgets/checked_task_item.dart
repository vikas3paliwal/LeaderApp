import 'package:flutter/material.dart';

class CheckedTaskItem extends StatefulWidget {
  bool allchecked;
  CheckedTaskItem([bool allchecked]) {
    this.allchecked = allchecked;
  }

  @override
  _CheckedTaskItemState createState() => _CheckedTaskItemState();
}

class _CheckedTaskItemState extends State<CheckedTaskItem> {
  bool checked = false;
  @override
  // TODO: implement widget

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    //alignment: Alignment.topLeft,
                    height: 20,
                    //color: Color.fromRGBO(30, 95, 116, 1),
                    child: Checkbox(
                      activeColor: Colors.amber,
                      value: widget.allchecked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                          widget.allchecked = value;
                        });
                      },
                    )),
              ),
              Center(
                  child: Text(
                "27/12/2020",
                style: TextStyle(color: Colors.black),
              )),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                  child: Text(
                "At 1:30 meeting to attend,2:30 assignment submission",
                softWrap: true,
                overflow: TextOverflow.fade,
                //maxLines: 7,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
