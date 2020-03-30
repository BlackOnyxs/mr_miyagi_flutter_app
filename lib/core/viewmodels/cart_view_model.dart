
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/cart_service.dart';
import 'package:mr_miyagi_app/core/services/dialog_service.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/error_constant.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/utils/validators.dart';
import 'package:mr_miyagi_app/core/viewmodels/base_model.dart';
import 'package:rxdart/subjects.dart';

import '../../locator.dart';

class CartViewModel extends BaseModel with Validators{
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  CartService _cartService = locator<CartService>();

  final _orderController = new BehaviorSubject<OrderModel>();
  Stream<OrderModel> get orderStream =>_orderController.stream;
  OrderModel get currentOrder => _orderController.value;

bool getState(){
  if (_cartService.currentState ) {
    _orderController.sink.add(_cartService.currentOrder);
  }
  return _cartService.currentState;
}




AddressModel getPrimaryAddress(){
  if (_authenticationService.currentUser.address != null && 
      _authenticationService.currentUser.address.length >0) {
    return _authenticationService.currentUser.address[0];
  } else {
    return null;
  }
}

Future sentOrder() async{
  setBusy(true);
  if (_authenticationService.currentUser.address != null) {
    if ( _authenticationService.currentUser.address.length >= 0 ) {
      for (var item in _cartService.currentOrder.localFoods) {
        item.state = false;
      }
      await _firestoreService.sentOrder(_cartService.currentOrder).whenComplete(navigateToOrderView);
    }
  }else if (_authenticationService.currentUser.address == null || 
          _authenticationService.currentUser.address.length == 0 ){
    await _dialogService.showDialog(
      title: 'Address Not Config',
      typeAlert: NAVIGATE,
      description: 'You have not provided an address. Press Ok to configure one.',

    );
  }
  notifyListeners();
  setBusy(false);
}
void navigateToOrderView(){
  if( _authenticationService.currentUser.activeOrders == null ){
    _authenticationService.currentUser.activeOrders = new List();
  }
  _authenticationService.currentUser.activeOrders.add(_cartService.currentOrder.id);
    _firestoreService.updateUser( _authenticationService.currentUser);
  
  _navigationService.navigateToPop(ORDER_VIEW_ROUTE, arg: _cartService.currentOrder.id );
  _cartService.reset();
}

void navigateTo( String path, {dynamic arg} ){
  _navigationService.navigateToPush(path);
}
void dismissAlert(){
  _navigationService.goBack();
}

deleteFood( String id ){
  if (_cartService.currentOrder.localFoods != null) {
   List<FoodModel> toRemove = new List();
    if(_cartService.currentOrder.localFoods.length >= 0){
      _cartService.currentOrder.localFoods.forEach((e){
        if (e.id == id) {
          toRemove.add(e);
          final sub = (double.parse(_cartService.currentOrder.subTotalPrice) -((double.parse(e.price)) * double.parse(cant)));
          _cartService.currentOrder.subTotalPrice = sub.toString(); 
        }
      });
      _cartService.currentOrder.localFoods.removeWhere((e) => toRemove.contains(e));
    }else{
      _orderController.sink.addError(CART_EMPTY_ERROR);
    }
  }
}

updateOrder( String id, String cant ){
  if (_cartService.currentOrder.localFoods != null) {
    if(_cartService.currentOrder.localFoods.length >= 0){
      _cartService.currentOrder.localFoods.forEach((e){
        if (e.id == id) {
          _cartService.currentOrder.subTotalPrice  = (double.parse(_cartService.currentOrder.subTotalPrice) - (double.parse(e.price)) * e.cant ).toString();
          var newPrice = (double.parse(e.price) * (double.parse(cant)));
          e.cant = int.parse(cant);
          _cartService.currentOrder.subTotalPrice  = (double.parse(_cartService.currentOrder.subTotalPrice) + newPrice).toString();
        }
      });
    }else{
      _orderController.sink.addError(CART_EMPTY_ERROR);
    }
  }
}

final _cantContoller    = BehaviorSubject<String>(); 
Stream<String> get cantStream => _cantContoller.stream.transform( validateCant );
Function(String) get changeCant => _cantContoller.sink.add;
String get cant => _cantContoller.value;

goback(){
  _navigationService.goBack();
}
dispose(){
  _orderController?.close();
  _cantContoller?.close();
}

}