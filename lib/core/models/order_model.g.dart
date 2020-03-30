// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['id'] as String,
    customerId: json['customerId'] as String,
    employeeId: json['employeeId'] as String,
    restaurantId: json['restaurantId'] as String,
    restaurantName: json['restaurantName'] as String,
    subTotalPrice: json['subTotalPrice'] as String,
    deliveryPrice: json['deliveryPrice'] as String,
    totalPrice: json['totalPrice'] as String,
    state: json['state'] as int,
    localFoods: (json['localFoods'] as List)
        ?.map((e) =>
            e == null ? null : FoodModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    restaurantLocation: json['restaurantLocation'] == null
        ? null
        : LatLng.fromJson(json['restaurantLocation'] as Map<String, dynamic>),
    userAddress: json['userAddress'] == null
        ? null
        : AddressModel.fromJson(json['userAddress'] as Map<String, dynamic>),
    position: json['position'],
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'employeeId': instance.employeeId,
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'subTotalPrice': instance.subTotalPrice,
      'deliveryPrice': instance.deliveryPrice,
      'totalPrice': instance.totalPrice,
      'state': instance.state,
      'localFoods': instance.localFoods?.map((e) => e?.toJson())?.toList(),
      'restaurantLocation': instance.restaurantLocation?.toJson(),
      'userAddress': instance.userAddress?.toJson(),
      'position': instance.position,
    };
