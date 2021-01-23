import 'package:Leader/customs/label_painter.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String labelName;
  final Color labelColor;
  final int customers;
  Label({this.customers, this.labelColor, this.labelName});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {},
          child: Container(
            //width: MediaQuery.of(context).size.width,
            child: Card(
              child: Stack(children: [
                // CustomPaint(
                //   painter: LabelCustomPainter(),
                //   size: Size(10, 10),
                // ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(
                    Icons.local_offer,
                    color: labelColor,
                  ),
                  title: Text(
                    labelName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: customers == null
                      ? null
                      : Text(customers.toString() + " " + 'CUSTOMERS'),
                ),
              ]),
            ),
          ),
        ));
  }
}

// Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: ListTile(
//                         // onTap: () {
//                         //   pushNewScreen(
//                         //     context,
//                         //     screen: SelectedLabelScreen(e.labelId),
//                         //     pageTransitionAnimation:
//                         //         PageTransitionAnimation.slideRight,
//                         //     withNavBar: false,
//                         //   );
//                         // },
//                         dense: true,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 0),
//                         leading: Icon(
//                           Icons.local_offer,
//                           color: e.color,
//                         ),
//                         title: Text(
//                           e.labelName.toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         trailing: e.label == null
//                             ? null
//                             : Text(e.label.keys.length.toString() +
//                                 " " +
//                                 'CUSTOMERS'),
//                       ),
//                     ),
