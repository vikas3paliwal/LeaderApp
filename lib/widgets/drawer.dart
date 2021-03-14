import 'package:Leader/screens/conversion.dart';
import 'package:Leader/screens/emi_calculator.dart';
import 'package:Leader/widgets/languageDialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(child: Image.asset('assets/images/leadgrow.jpeg')),
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Loan Calculator'.tr()),
            onTap: () {
              pushNewScreen(
                context,
                screen: EMIScreen(),
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
                withNavBar: false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.tab),
            title: Text('Conversion Table'.tr()),
            onTap: () {
              pushNewScreen(
                context,
                screen: ConversionScreen(),
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
                withNavBar: false,
              );
            },
          ),
          ListTile(
            title: Text('Language'.tr()),
            leading: Icon(Icons.language),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => LanguageDialog());
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.photo_library),
          //   title: Text('Upcoming Projects'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.video_library),
          //   title: Text('News'),
          // ),
        ],
      ),
    );
  }
}
