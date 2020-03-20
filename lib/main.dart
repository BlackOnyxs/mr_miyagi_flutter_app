import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/router.dart' as router ;
import 'package:mr_miyagi_app/ui/views/sign_up_view.dart';
import 'core/utils/routing_constant.dart' as routes;
import 'package:mr_miyagi_app/locator.dart';

import 'core/services/navigation_service.dart';

import 'managers/dialog_manager.dart';
import 'ui/views/startup_view.dart';

void main() {
   setUpLocator();
   runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mr Miyagi App',
      navigatorKey: locator<NavigationService>().navigatorKey,
      builder: ( context, child ) => Navigator(
        onGenerateRoute: ( settings ) => MaterialPageRoute(
          builder: ( context ) => DialogManager(child: child)
        ),
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.START_UP_VIEW_ROUTE,
    );
  }
}