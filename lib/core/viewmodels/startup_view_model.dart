
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';

import '../../locator.dart';
import 'base_model.dart';

class StartUpViewModel extends BaseModel{
  final _autheticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _autheticationService.isUserLoggedIn();

    if(hasLoggedInUser){
      if(_autheticationService.currentUser != null ){
        if (_autheticationService.currentUser.address != null &&
            _autheticationService.currentUser.address.length >= 1 ) {
          _navigationService.navigateToPop(HOME_VIEW_ROUTE);
        }else{
          _navigationService.navigateToPop(ADDRESS_SETTINGS_VIEW_ROUTE); 
        }
      }
    }else{
      //TODO:change this for pop function
      _navigationService.navigateToPop(SIGNUP_VIEW_ROUTE);
    }
  }
}