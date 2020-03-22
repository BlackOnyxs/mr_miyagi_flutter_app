import 'package:get_it/get_it.dart';
import 'package:mr_miyagi_app/core/services/cart_service.dart';
import 'package:mr_miyagi_app/core/viewmodels/daily_lunch_view_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/home_view_model.dart';

import 'core/services/auth_service.dart';
import 'core/services/dialog_service.dart';
import 'core/services/firestore_service.dart';
import 'core/services/navigation_service.dart';
import 'core/services/local_db_service.dart';
import 'core/share_pref/user_preferences.dart';
import 'core/viewmodels/food_card_model_view.dart';
import 'core/viewmodels/food_detail_alert_model.dart';
import 'core/viewmodels/location_setting_view_model.dart';
import 'core/viewmodels/login_view_model.dart';
import 'core/viewmodels/menu_view_model.dart';
import 'core/viewmodels/settings_view_model.dart';
import 'core/viewmodels/sign_up_view_model.dart';
import 'core/viewmodels/startup_view_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  // Services
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => AuthenticationService());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LocalDBService());
  locator.registerLazySingleton(() => UserPreferences());
  locator.registerLazySingleton(() => CartService());

  //View Models 
  locator.registerLazySingleton(() => StartUpViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => LogInViewModel());

  locator.registerLazySingleton(() => SettingViewModel());
  locator.registerLazySingleton(() => LocationSettingViewModel());

  locator.registerLazySingleton(() => HomeViewModel());

  locator.registerLazySingleton(() => DailyLunchViewModel());
  locator.registerLazySingleton(() => FoodDetailAlertModel());
  locator.registerLazySingleton(() => MenuViewModel());
  locator.registerLazySingleton(() => FoodCardModelView());

  
}