import 'package:Leader/screens/labeled_customers_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:easy_localization/easy_localization.dart';

class AppLabel extends StatelessWidget {
  final String labelName;
  final Color labelColor;

  // final int customers;
  final String id;
  final int custmcount;
  final List<String> customids;
  AppLabel(
      {
      // this.customers,
      this.labelColor,
      this.labelName,
      this.id,
      this.customids,
      this.custmcount});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        dense: true,
        onTap: customids == null
            ? null
            : () => pushNewScreen(context,
                screen: LabeledCustomerScreen(id, customids),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino),
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
        trailing: customids == null || customids.isEmpty
            ? null
            : Text(customids.length.toString() + " " + 'CUSTOMERS'.tr()),
      ),
    );
  }
}
