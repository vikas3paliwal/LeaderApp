import 'package:Leader/models/label.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/leads_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LeadTile extends StatefulWidget {
  final String id;
  final String name;
  final List<Label> labels;
  final bool showLabels;

  LeadTile({this.labels, this.id, this.name, this.showLabels});

  @override
  _LeadTileState createState() => _LeadTileState();
}

class _LeadTileState extends State<LeadTile> {
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<Customers>(context);
    final customer = widget.id == null ? null : customers.findById(widget.id);
    return Container(
      key: ValueKey(widget.id),
      decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
            offset: const Offset(4.0, 8.0),
            blurRadius: 14.0,
            spreadRadius: -15.0,
            color: Colors.grey[800]),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
            bottomLeft: const Radius.circular(30),
            topLeft: const Radius.circular(30),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: widget.id == null
                ? null
                : () => pushNewScreen(
                      context,
                      screen: LeadProfileScreen(widget.id),
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                      withNavBar: false,
                    ),
            leading: Container(
              width: 60,
              height: 55.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange[300],
              ),
              child: const Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 40,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (widget.labels != null)
                  widget.showLabels ?? true
                      ? Container(
                          width: 200,
                          height: 25,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.labels.length,
                              itemBuilder: (ctx, i) => widget.labels
                                  .map(
                                    (e) => Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Center(
                                              child: Text(
                                            e.labelName,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                        color: e.color),
                                  )
                                  .toList()[i]),
                        )
                      : Container(),
              ],
            ),
            tileColor: Colors.white,
            // subtitle: Text('23/3/2021'),
            trailing: customer == null
                ? null
                : Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: customer.pinned
                                ? Image.asset(
                                    'assets/images/filled_pin_2.png',
                                    height: 25,
                                  )
                                : Image.asset(
                                    'assets/images/empty_pin.png',
                                    color: Theme.of(context).primaryColor,
                                    height: 25,
                                  ),
                            onPressed: () {
                              setState(() {
                                customer.pinned = !customer.pinned;
                                // _pinned = !_pinned;
                                customers.onchangedpin(customer);
                              });
                            }),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () async {
                            var delete = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text('Are You Sure ?'.tr()),
                                      content: Text(
                                          'Do you want to delete'.tr() + ' ?'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop(false);
                                            },
                                            child: Text('Cancel'.tr())),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop(true);
                                            },
                                            child: Text('Yes'.tr())),
                                      ],
                                    ));
                            if (delete) {
                              customers.removeCustomer(customer.customerId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
