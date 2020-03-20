
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';

import '../../locator.dart';
import 'base_model.dart';

class StartUpViewModel extends BaseModel{
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if(hasLoggedInUser){
      if(_authenticationService.currentUser != null ){
        if (_authenticationService.currentUser.address != null &&
            _authenticationService.currentUser.address.length >= 1 ) {
          _navigationService.navigateToPop(LOCATION_SETTINGS_VIEW_ROUTE);
        }else{
          _navigationService.navigateToPop(HOME_VIEW_ROUTE); 
        }
      }
    }else{
      _navigationService.navigateToPop(LOGIN_VIEW_ROUTE);
    }
  }
}