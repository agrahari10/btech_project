import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationServices {
  static GlobalKey<NavigatorState> NavigatorKey =
      new GlobalKey<NavigatorState>();

  void removAndNavigateToRoute(String _route) {
    NavigatorKey.currentState?.popAndPushNamed(_route);
  }

  void navigateToRoute(String _route) {
    NavigatorKey.currentState?.pushNamed(_route);
  }

  void navigateToPage(Widget _page) {
    NavigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (BuildContext _context){
      return _page;
    }));
  }
  void goBack(){
    NavigatorKey.currentState?.pop();
  }

}