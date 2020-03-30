import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/ui/views/active_orders_view.dart';
import 'package:mr_miyagi_app/ui/views/cart_view.dart';
import 'package:mr_miyagi_app/ui/views/daily_lunch_view.dart';
import 'package:mr_miyagi_app/ui/views/edit_food_alert_view.dart';
import 'package:mr_miyagi_app/ui/views/location_setting_view.dart';
import 'package:mr_miyagi_app/ui/views/map_setting_view.dart';
import 'package:mr_miyagi_app/ui/views/menu_view.dart';
import 'package:mr_miyagi_app/ui/views/order_view.dart';
import 'package:mr_miyagi_app/ui/widgets/food_detail_view_alert.dart';


import 'core/models/food_model.dart';
import 'core/utils/routing_constant.dart' as routes;
import 'ui/views/home_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/setting_view.dart';
import 'ui/views/sign_up_view.dart';
import 'ui/views/startup_view.dart';
import 'ui/widgets/food_card_swiper.dart';

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

    case routes.MAP_SETTINGS_VIEW_ROUTE: 
    AddressModel address = settings.arguments;
      return MaterialPageRoute( builder: ( context) => MapSettingView(currentAddress: address));

    case routes.HOME_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => HomeView());

    case routes.DAILY_LUNCH_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => DailyLunchView());

    case routes.FOOD_DETAIL_VIEW_ROUTE:
      DailyLunchModel dailyLunch = settings.arguments;
      return MaterialPageRoute( builder: ( context) => FoodDetailViewAlert( dailyLunch: dailyLunch));

    case routes.MENU_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => MenuView());
    
    case routes.MENU_SECTION_DETAIL_ROUTE:
      List<FoodModel> foods = settings.arguments;
      return MaterialPageRoute( builder: ( context) => FoodCardSwiper( foods: foods));
    
    case routes.CART_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => CartView());
    
    case routes.ORDER_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => OrderView( id: settings.arguments));
    
    case routes.ACTIVE_ORDERS_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => ActiveOrdesView());

    case routes.EDIT_FOOD_ALERT_VIEW_ROUTE:
      return MaterialPageRoute( builder: ( context) => EditFoodAlertView( food: settings.arguments ));
    
    default: 
    return MaterialPageRoute( builder: ( context) => StartUpView());
  }
}