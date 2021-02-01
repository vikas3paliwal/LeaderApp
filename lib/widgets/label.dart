import 'package:Leader/customs/label_painter.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Label extends StatelessWidget {
  final String labelName;
  final Color labelColor;
  final int customers;
  final String id;
  Label({this.customers, this.labelColor, this.labelName, this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Dismissible(
          key: ValueKey(id),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Are You Sure?'),
                      content: Text('Do you want to delete this label?'),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: Text('Cancel')),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                            child: Text('Yes')),
                      ],
                    ));
          },
          background: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              // vertical: 4,
            ),
            child: Icon(
              Icons.delete,
              size: 40,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).errorColor.withOpacity(0.4),
              Colors.redAccent
            ], begin: Alignment.topLeft, end: Alignment.topRight)),
          ),
          onDismissed: (_) {
            Provider.of<Labels>(context, listen: false).deleteLabel(id);

            Provider.of<Customers>(context, listen: false).deleteLabel(id);
          },
          child: ListTile(
            dense: true,
            tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            // contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
