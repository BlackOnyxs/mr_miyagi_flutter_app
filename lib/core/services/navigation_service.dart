import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateToPush( String routeName, {dynamic arg} ){
    return navigatorKey.currentState.pushNamed(routeName, arguments: arg);
  }
  Future<dynamic> navigateToPop( String routeName, {dynamic arg} ) async {
    return navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arg);
  }
   bool goBack(){
     return navigatorKey.currentState.pop();
   }

}