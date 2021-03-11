///
///For Debugging purpose.
///

import 'package:flutter/material.dart';

class NavigatorHistory extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("${route.settings.name} pushed");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("${route.settings.name} popped");
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print("${oldRoute.settings.name} is replaced by ${newRoute.settings.name}");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("${route.settings.name} removed");
  }
}