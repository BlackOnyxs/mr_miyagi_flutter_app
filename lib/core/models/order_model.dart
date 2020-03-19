
import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';
import 'food_model.dart';
import 'latlng_model.dart';

part 'order_model.g.dart';
@JsonSerializable( explicitToJson: true)
class OrderModel{
  String id;
  String customerId;
  String employeeId;
  String restaurantId;
  String restaurantName;
  String subTotalPrice;
  String deliveryPrice;
  String totalPrice;
  int state;
  List<FoodModel> localFoods;
  LatLng restaurantLocation;
  AddressModel userAddress;
  //List<String> chat; TODO: create this POJO
  OrderModel({
    this.id,
    this.customerId,
    this.employeeId,
    this.restaurantId,
    this.restaurantName,
    this.subTotalPrice,
    this.deliveryPrice,
    this.totalPrice,
    this.state,
    this.localFoods,
    this.restaurantLocation,
    this.userAddress,
    //this.chat,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
  return 'Order{ id: $id, customerId: $customerId, employeeId: $employeeId, subTotalPrice: $subTotalPrice, State: $state, deliveryPrice: $deliveryPrice, totalPrice: $totalPrice, localFoods: ${localFoods.toString()}, location: $restaurantLocation, User location: ${userAddress.toString()}}';
   }

}