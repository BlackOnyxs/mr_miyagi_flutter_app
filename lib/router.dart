
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'core/utils/routing_constant.dart' as routes;
import 'ui/views/address_setting_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/sign_up_view.dart';
import 'ui/views/startup_view.dart';
import 'ui/views/home_view.dart';

Route<dynamic> generateRoute( RouteSettings settings ){
  switch ( settings.name ){
    case routes.START_UP_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => StartUpView());

    case routes.SIGNUP_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => SignUpView());

    case routes.LOGIN_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => LoginView());

    case routes.HOME_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => HomeView());

    case routes.ADDRESS_SETTINGS_VIEW_ROUTE: 
      return MaterialPageRoute( builder: ( context) => AddressSettingView());
    
    default: 
    return MaterialPageRoute( builder: ( context) => StartUpView());
  }
}