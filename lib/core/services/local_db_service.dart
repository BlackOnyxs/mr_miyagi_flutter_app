

import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/models/local_food.dart';
import 'package:mr_miyagi_app/core/models/local_order.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';

import 'db_provider.dart';

class LocalDBService{
  
  getVersion()async {
    return await DBProvider.db.getVersion();
  }
  getOrders ( String id ) async {
   return await DBProvider.db.getAllOrders( id );
  }

  addOrder( OrderModel order ) async {
    //TODO: move this to Utils.dart
    for (var i = 0; i < order.localFoods.length; i++) {
      FoodModel _currentFood =  order.localFoods[i];
      LocalFood _currentLocalFood = new LocalFood(
        id: _currentFood.id,
        name: _currentFood.displayName,
        price: _currentFood.price,
        orderId: order.id
      );
      await DBProvider.db.newFood(_currentLocalFood);
    }
    LocalOrder _localOrder = new LocalOrder(
      id: order.id,
      restaurantId: order.restaurantId,
      userId: order.customerId,
      subTotalPrice: order.subTotalPrice,
      deliveryPrice: order.deliveryPrice,
      totalPrice: order.totalPrice,
       latitudeC: order.userAddress.location.lat.toString(),
      longitudeC: order.userAddress.location.lng.toString(),
      latitudeR: order.restaurantLocation.lat.toString(),
      longitudeR: order.restaurantLocation.lng.toString()
    );
    await DBProvider.db.newRowOrder(_localOrder);
  }

  getUserById( String id ) async{
    return await DBProvider.db.getUserById(id);
  }

  addUser( String id ) async {
    return await DBProvider.db.newRowUser(id);
  }

}