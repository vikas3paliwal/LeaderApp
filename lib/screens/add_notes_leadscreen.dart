import 'package:Leader/providers/customers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNotesLeadScreen extends StatefulWidget {
  final String customerId;
  final String name;

  AddNotesLeadScreen({this.customerId, this.name});

  @override
  _AddNotesLeadScreenState createState() => _AddNotesLeadScreenState();
}

class _AddNotesLeadScreenState extends State<AddNotesLeadScreen> {
  final DateFormat format = DateFormat.yMMMd();
  bool _initial = true;

  TextEditingController _controller = TextEditingController();
  FocusNode controllernode = FocusNode();
  // TextEditingController _controller2 = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_initial) {
      final customer =
          Provider.of<Customers>(context).findById(widget.customerId);
      if (customer.notes == null) {
        _controller.text = ' ';
      } else {
        _controller.text = customer.notes.reversed.join(' ');
      }
    }
    _initial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final customer =
        Provider.of<Customers>(context).findById(widget.customerId);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
        return true;
      },
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notes - " + widget.name),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Text(
                      format.format(DateTime.now()),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    TextFormField(
                      focusNode: controllernode,
                      controller: _controller,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration.collapsed(
                        hintText: ' ',
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.09),
                      ),
                      maxLines: null,
                    ),
                  ],
                )),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (customer.notes == null) {
                customer.notes = [
                  '\n' +
                      '\n' +
                      format.format(DateTime.now()) +
                      '\n' +
                      _controller.text
                ];
              } else {
                customer.notes.clear();
                customer.notes.add('\n' +
                    '\n' +
                    format.format(DateTime.now()) +
                    '\n' +
                    _controller.text);
              }

              FocusScope.of(context).unfocus();
              Future.delayed(Duration(milliseconds: 150))
                  .whenComplete(() => Navigator.of(context).pop());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Add",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
