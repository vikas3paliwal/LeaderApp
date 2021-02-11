import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';
import 'package:Leader/widgets/leads_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabeledCustomerScreen extends StatelessWidget {
  final List<String> customids;
  final String id;
  LabeledCustomerScreen(this.id, this.customids);
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<Customers>(context).findByLabel(customids);
    final label = Provider.of<Labels>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(label.labelName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: customers.length,
            itemBuilder: (ctx, i) => customers
                .map((e) => InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: LeadTile(
                        id: e.customerId,
                        labels: e.labels,
                        name: e.name,
                      ),
                    ))
                .toList()[i]),
      ),
    );
  }
}
