import 'package:Leader/models/label.dart' as lb;
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLabelScreen extends StatefulWidget {
  final String customerId;
  AddLabelScreen(this.customerId);
  @override
  _AddLabelScreenState createState() => _AddLabelScreenState();
}

class _AddLabelScreenState extends State<AddLabelScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final label = Provider.of<Labels>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Labels"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => label.labels
            .map(
              (e) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.platform,
                      value: e.label == null
                          ? false
                          : e.label[widget.customerId] == null
                              ? false
                              : e.label[widget.customerId],
                      onChanged: (val) {
                        setState(() {
                          if (e.label != null)
                            e.label[widget.customerId] = val;
                          else {
                            e.label = {widget.customerId: true};
                            // if (e.customers != null) {
                            //   e.customers.add(widget.customerId);
                            // } else {

                            // }
                          }
                        });
                      },
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      secondary: Icon(
                        Icons.local_offer,
                        color: e.color,
                      ),
                      title: Text(
                        e.labelName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
              ),
            )
            .toList()[i],
        itemCount: label.labels.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var selectedLabels = label.labels
              .where((element) => element.label == null
                  ? false
                  : element.label[widget.customerId] == true)
              .toList();

          final customers = Provider.of<Customers>(context, listen: false);
          customers.addLabels(selectedLabels, widget.customerId);

          label.addCustomer(widget.customerId, selectedLabels);
          Navigator.of(context).pop();
        },
        child: Text('Add'),
      ),
    );
  }
}
