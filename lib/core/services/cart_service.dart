import 'package:mr_miyagi_app/core/models/order_model.dart';


class CartService {
  bool _cartCurrentState = false;
  bool get currentState => _cartCurrentState;

  OrderModel _order ;
  OrderModel get currentOrder => _order;
  
  void setState( bool state){
    _cartCurrentState = state;
  }
  
  void reset(){
    _cartCurrentState = false;
  }
  void createOrder( OrderModel newOrder){
    _order = newOrder;
  }
}