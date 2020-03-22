import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/services/cart_service.dart';
import 'package:mr_miyagi_app/core/utils/validators.dart';
import 'package:mr_miyagi_app/core/viewmodels/base_model.dart';
import 'package:mr_miyagi_app/locator.dart';
import 'package:rxdart/subjects.dart';

class FoodDetailAlertModel extends BaseModel with Validators{
CartService _cartService = locator<CartService>();
  double _subTotal = 0;

 
void addFoodToOrder( DailyLunchModel dailyLunch ){
  setBusy(true);
  if ( _cartService.currentState == false ) {
    _cartService.setState(true);
    OrderModel _newOrder = new OrderModel();
    _newOrder.state = 0;
    _newOrder.id = new DateTime.now().millisecond.toString();
    _newOrder.localFoods = new List();
    if (_newOrder.subTotalPrice == null) {
      _newOrder.subTotalPrice = 0.0.toString();
    }
    //TODO: add this within function on utils
    _newOrder.localFoods.add(dailyLunch.food);
    _subTotal += double.parse(dailyLunch.food.price);
    _newOrder.subTotalPrice = _subTotal.toStringAsFixed(2);
    _newOrder.totalPrice = _subTotal.toStringAsFixed(2);
    _cartService.createOrder(_newOrder);
    
  }else{
    _cartService.currentOrder.localFoods.add(dailyLunch.food);
    _subTotal = double.parse(_cartService.currentOrder.subTotalPrice);
    _cartService.currentOrder.subTotalPrice = (_subTotal + double.parse(dailyLunch.food.price)).toStringAsFixed(2);
    _cartService.currentOrder.totalPrice = (_subTotal + double.parse(dailyLunch.food.price)).toStringAsFixed(2);
  }
  _cantContoller.sink.add('0')  ;
  setBusy(false); 
  notifyListeners();
}
void hideCart( BuildContext context ){
  setBusy(true);
  Navigator.of(context).pop();
  setBusy(false);
  notifyListeners();
}
final _cantContoller    = BehaviorSubject<String>();

Stream<String> get cantStream => _cantContoller.stream.transform( validateCant );
Function(String) get changeCant => _cantContoller.sink.add;
String get cant => _cantContoller.value;
void dispose(){
  _cantContoller?.close();
}
}