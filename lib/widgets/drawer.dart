import 'package:Leader/providers/customers.dart';
import 'package:Leader/screens/OnBoarding/on_boarding.dart';
import 'package:Leader/screens/Signup/signup_screen.dart';
import 'package:Leader/screens/conversion.dart';
import 'package:Leader/screens/emi_calculator.dart';
import 'package:Leader/screens/home_screen.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:Leader/widgets/contactwidget.dart';
import 'package:Leader/widgets/languageDialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contact/contact.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> ctx;
  SideDrawer(this.ctx);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool _loading = false;
  bool _logoutloading = false;
  Future<void> _askPermissions(BuildContext context) async {
    PermissionStatus permissionStatus;
    while (permissionStatus != PermissionStatus.granted) {
      try {
        permissionStatus = await _getContactPermission();
        if (permissionStatus != PermissionStatus.granted) {
          // _hasPermission = false;
          _handleInvalidPermissions(permissionStatus);
        } else {
          print('success');
          // _hasPermission = true;
        }
      } catch (e) {
        if (await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: Text('Contact Permissions'),
                    content: Text(
                        'We are having problems retrieving permissions.  Would you like to '
                        'open the app settings to fix?'),
                    actions: [
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('Close'),
                      ),
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Settings'),
                      ),
                    ],
                  );
                }) ==
            true) {
          await openAppSettings();
        }
      }
    }

    // await Navigator.of(context).pushReplacementNamed('/contactsList');
  }

  Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result;
    } else {
      return status;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Access to location data denied',
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: 'PERMISSION_DISABLED',
          message: 'Location data is not available on device',
          details: null);
    }
  }

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
            leading: Image.asset(
              'assets/images/calculator.png',
              height: 27,
              scale: 2,
            ),
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
            leading: Image.asset(
              'assets/images/conversion.png',
              height: 27,
              scale: 2,
            ),
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
            leading: Image.asset(
              'assets/images/language.jpg',
              height: 27,
              scale: 2,
            ),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => LanguageDialog());
            },
          ),
          ListTile(
            title: Text('Import Data'.tr()),
            trailing: _loading ? PlatformCircularProgressIndicator() : null,
            leading: Image.asset(
              'assets/images/import.png',
              height: 23,
              scale: 2,
            ),
            onTap: () async {
              setState(() {
                _loading = true;
              });
              Map<Contact, bool> contacts = {};

              await _askPermissions(context);
              await Contacts.streamContacts().forEach((contact) {
                contacts[contact] = false;
                print("${contact.displayName}");
                print("${contact.phones}");
              });
              setState(() {
                _loading = false;
              });
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text('Cancel'.tr())),
                    TextButton(
                        onPressed: () {
                          List<List<String>> contact = [];
                          contacts.forEach((key, value) {
                            if (value) {
                              contact
                                  .add([key.displayName, key.phones[0].value]);
                              print(value);
                            }
                          });
                          Provider.of<Customers>(context, listen: false)
                              .addContacts(contact);
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'.tr()))
                  ],
                  content: Container(
                    height: 350,
                    child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (ctx, i) => contacts.keys
                            .map((e) => ContactTile(e, contacts))
                            .toList()[i]),
                  ),
                ),
                useSafeArea: true,
              ).whenComplete(() {
                Provider.of<Customers>(context, listen: false).fetchData();
              });

              print(flutterContactLog.name);
            },
          ),
          ListTile(
            title: Text('Export Data'.tr()),
            leading: Image.asset(
              'assets/images/export.png',
              height: 27,
              scale: 2,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Log Out'.tr()),
            leading: Image.asset(
              'assets/images/logout.png',
              height: 25,
              scale: 2,
            ),
            trailing: _logoutloading ? CircularProgressIndicator() : null,
            onTap: () {
              setState(() {
                _logoutloading = true;
              });
              ApiHelper().logOut().whenComplete(() {
                _logoutloading = false;
                Navigator.of(context).pop();

                Navigator.pushAndRemoveUntil(
                    widget.ctx.currentContext,
                    MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                    (route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
