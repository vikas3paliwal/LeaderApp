import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedLabelScreen extends StatelessWidget {
  final String id;
  SelectedLabelScreen(this.id);
  @override
  Widget build(BuildContext context) {
    //final label=Provider.of<Labels>(context,listen: false).findById(id);
    final customers =
        Provider.of<Customers>(context, listen: false).findByLabel(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, i) => customers
              .map((e) => Center(
                    child: Text(e.name),
                  ))
              .toList()[i]),
    );
  }
}
