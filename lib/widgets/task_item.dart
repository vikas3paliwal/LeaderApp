import 'package:Leader/customs/task_painter.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    icon: Icon(
                      Icons.check_box_outlined,
                    ),
                    iconSize: 28,
                    color: Color(0xffC7C7C7),
                    onPressed: () {}),
                SizedBox(
                  width: 80,
                ),
                IconButton(
                    icon: Image.asset(
                      'assets/images/empty_pin.png',
                      color: Colors.white,
                      height: 25,
                    ),
                    color: Color(0xffC7C7C7),
                    onPressed: () {}),
              ],
            ),
          ),
          Positioned(
              // top: 10,
              bottom: 0,
              child: Container(
                height: 30,
                width: 185,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "27/12/2020",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "12:45",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
                'Today i read a book on my favorite subject, it felt like i was doing something that i was happy about for the first time',
                style: TextStyle(color: Color(0xff3f3f40), fontSize: 16),
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
          ),
        ],
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
