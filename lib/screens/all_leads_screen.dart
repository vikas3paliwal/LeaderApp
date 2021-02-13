import 'package:Leader/providers/customers.dart';
import 'package:Leader/widgets/leads_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllLeadsScreen extends StatelessWidget {
  final Function(String x, String y) callback;
  AllLeadsScreen(this.callback);
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<Customers>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: customers.customers.length,
            itemBuilder: (ctx, i) => customers.customers
                .map((e) => InkWell(
                      onTap: () {
                        print('object');
                        callback(e.name, e.customerId);
                        Navigator.of(context).pop();
                      },
                      child: LeadTile(
                        labels: e.labels,
                        name: e.name,
                      ),
                    ))
                .toList()[i]),
      ),
    );
  }
}
