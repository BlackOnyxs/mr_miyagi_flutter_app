import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/services/cart_service.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../locator.dart';
import 'base_model.dart';

class OrderViewModel extends BaseModel{
FirestoreService _firestoreService = locator<FirestoreService>();
CartService _cartService = locator<CartService>();
NavigationService _navigationService = locator<NavigationService>();

final _orderController = BehaviorSubject<OrderModel>();
Stream<OrderModel> get orderStream => _orderController.stream;


Future listenOrder( String id ) async {
    try {
      setBusy(true);
      _firestoreService.listenOrder(id).listen( ( orderData ){
        if (orderData != null ) {
          _orderController.sink.add(orderData);
          notifyListeners();
        }
        setBusy(false);
      }).onError((e){
        switch (e.message) {
          case "NOT_FOUND":
            /* TODO: display Error */
            break;
          default:
        }
      });
    } catch (e) {
      if (e is PlatformException) {
         //TODO: 
      }
    }
  }


OrderModel getOrder(){
  return _cartService.currentOrder;
}
Future navigateTo(String path, {String arg } ) async {
  _navigationService.navigateToPush(path, arg: arg );
}
  

 @override
 void dispose() { 
   super.dispose();
  //  _firestoreService.dipose();
   _orderController?.close();
 }
}