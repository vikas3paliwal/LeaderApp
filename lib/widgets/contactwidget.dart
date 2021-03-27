import 'package:flutter/material.dart';
import 'package:flutter_contact/contact.dart';

class ContactTile extends StatefulWidget {
  final Map<Contact, bool> contactMap;
  final Contact contact;
  ContactTile(this.contact, this.contactMap);
  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.contact.displayName),
        value: widget.contactMap[widget.contact],
        onChanged: (val) {
          print(val);
          setState(() {
            widget.contactMap[widget.contact] =
                !widget.contactMap[widget.contact];
          });
        });
  }
}
