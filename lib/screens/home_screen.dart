import 'package:Leader/providers/labels.dart';
import 'package:Leader/widgets/customAppbar.dart';
import 'package:Leader/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:Leader/screens/labels_screen.dart';
import 'package:Leader/screens/leads_screen.dart';
import 'package:Leader/screens/customer_screen.dart';
import 'package:Leader/screens/my_business_screen.dart';
import 'package:Leader/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final mainscaffoldkey = GlobalKey<ScaffoldState>();
  PersistentTabController _bottomTabController;
  List<Widget> _buildScreens() {
    return [
      Leads(ctx: mainscaffoldkey),
      //CustomerScreen(),
      LabelScreen(
        UniqueKey(),
        ctx: mainscaffoldkey,
      ),
      TaskScreen(ctx: mainscaffoldkey),
      MyBusinessScreen(UniqueKey(), ctx: mainscaffoldkey)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.stacked_line_chart,
          ),
          activeColorAlternate: Colors.white,
          title: 'Leads'.tr(),
          inactiveColor: Colors.deepOrange[300],
          activeColor: Theme.of(context).primaryColor,
          textStyle: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 20,
          )),
      // PersistentBottomNavBarItem(
      //   icon: Icon(
      //     Icons.person_pin,
      //   ),
      //   title: 'Customers',
      //   inactiveColor: Colors.deepPurpleAccent,
      //   activeColor: Colors.deepOrange,
      //   textStyle: TextStyle(color: Colors.deepPurpleAccent),
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.local_offer,
        ),
        activeColorAlternate: Colors.white,
        title: 'Labels'.tr(),
        inactiveColor: Colors.deepOrange[300],
        activeColor: Theme.of(context).primaryColor,
        textStyle: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.notifications,
        ),
        activeColorAlternate: Colors.white,
        title: 'Tasks'.tr(),
        inactiveColor: Colors.deepOrange[300],
        activeColor: Theme.of(context).primaryColor,
        textStyle: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),
      ),
      PersistentBottomNavBarItem(
        activeColorAlternate: Colors.white,
        icon: Icon(
          Icons.business_sharp,
          //color: Colors.deepPurpleAccent,
        ),
        title: 'My Business'.tr(),
        inactiveColor: Colors.deepOrange[300],
        // Color.fromRGBO(190, 144, 99, 1),
        activeColor: Theme.of(context).primaryColor,
        textStyle: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),
      ),
    ];
  }

  @override
  void initState() {
    _bottomTabController = PersistentTabController(
      initialIndex: 0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _bottomTabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainscaffoldkey,
      body: PersistentTabView(
        context,
        popActionScreens: PopActionScreensType.all,
        padding: NavBarPadding.only(bottom: 2),
        neumorphicProperties: NeumorphicProperties(
          shape: BoxShape.rectangle,
          showSubtitleText: true,
          bevel: 1,
        ),

        routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
          Leads.routeName: (ctx) => Leads(
                ctx: mainscaffoldkey,
              ),
          LabelScreen.routeName: (ctx) =>
              LabelScreen(UniqueKey(), ctx: mainscaffoldkey),
          TaskScreen.routeName: (ctx) => TaskScreen(ctx: mainscaffoldkey),
          MyBusinessScreen.routeName: (ctx) =>
              MyBusinessScreen(UniqueKey(), ctx: mainscaffoldkey)
        }),
        controller: _bottomTabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        // resizeToAvoidBottomInset:
        //     true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows: true,
        // hideNavigationBarWhenKeyboardShows:
        //     true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: Colors.white,
        ),

        popAllScreensOnTapOfSelectedTab: false,
        //popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),

        navBarStyle: NavBarStyle.style7,
        // Choose the nav bar style with this property.
      ),
    );
  }
}
