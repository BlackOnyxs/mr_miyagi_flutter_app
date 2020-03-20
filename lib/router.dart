import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/ui/views/daily_lunch_view.dart';
import 'package:mr_miyagi_app/ui/views/location_setting_view.dart';


import 'core/utils/routing_constant.dart' as routes;
import 'ui/views/home_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/setting_view.dart';
import 'ui/views/sign_up_view.dart';
import 'ui/views/startup_view.dart';

Route<dynamic> generateRoute( RouteSettings settings ){
  switch ( settings.name ){
    case routes.START_UP_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => StartUpView());

    case routes.SIGNUP_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => SignUpView());

    case routes.LOGIN_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => LoginView());

    case routes.ADDRESS_SETTINGS_VIEW_ROUTE: 
    return MaterialPageRoute( builder: ( context) => SettingView());

    case routes.LOCATION_SETTINGS_VIEW_ROUTE: 
    AddressModel address = settings.arguments;
      return MaterialPageRoute( builder: ( context) => LocationSettingView(currentAddress: address));

    case routes.HOME_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => HomeView());

    case routes.DAILY_LUCNH_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => DailyLunchView());
    
    default: 
    return MaterialPageRoute( builder: ( context) => StartUpView());
  }
}