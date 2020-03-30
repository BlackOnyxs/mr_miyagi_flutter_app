import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/viewmodels/base_model.dart';
import 'package:mr_miyagi_app/locator.dart';
import 'package:rxdart/subjects.dart';

class ActiveOrderViewModel extends BaseModel{
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  final  _activeOrder = new BehaviorSubject<List<String>>();
  Stream<List<String>> get orderStream => _activeOrder;

  void getOrders(){
    if( _authenticationService.currentUser != null ){
      CustomerUser currentUser = _authenticationService.currentUser;
      if ( currentUser.activeOrders != null ) {
        _activeOrder.sink.add(currentUser.activeOrders);
      }
    }
  }
  void navigateTo( String path, {String id} ){
    _navigationService.navigateToPush( path, arg: id );
  }

  void dipose(){
    _activeOrder?.close();
  }
}