import 'package:flutter/material.dart';
import 'package:hexagon/hexagon_widget.dart';

class BusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 250,
                  color: Color.fromRGBO(252, 218, 183, 1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HexagonWidget.flat(
                          elevation: 10,
                          color: Color.fromRGBO(53, 53, 53, 1),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(53, 53, 53, 1),
                                // image: DecorationImage(
                                //   fit: BoxFit.cover,
                                //   image: NetworkImage(
                                //     'https://icon-library.com/images/facebook-icon-high-res/facebook-icon-high-res-4.jpg',
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          //inBounds: false,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(30, 95, 116, 1),
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 250,
                  color: Color.fromRGBO(30, 95, 116, 1),
                  //width: 250,
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //       begin: Alignment.centerLeft,
                  //       end: Alignment.centerRight,
                  //       colors: [
                  //         Color.fromRGBO(63, 63, 63, 1),
                  //         Color.fromRGBO(23, 23, 23, 1),
                  //       ]),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    'Ist FLOOR, QURASHI TOWER, NEW KOHINOOR CINEMA CIRCLE, Akhaliya Vikas Yojana, Jodhpur, Rajasthan 342001',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    '9899257321',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.mouse,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    'www.facebook.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    'max3samueal@gmail.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 60,

            //width: MediaQuery.of(context).size.width * 0.88,
            decoration: BoxDecoration(
                color: Color.fromRGBO(75, 93, 103, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Center(
                          child: Text(
                        "EDIT DETAILS",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 6,
                  thickness: 1.5,
                  color: Colors.white,
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Center(
                          child: Text(
                        "SEND BUSINESS CARD",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
