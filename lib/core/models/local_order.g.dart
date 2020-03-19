// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalOrder _$LocalOrderFromJson(Map<String, dynamic> json) {
  return LocalOrder(
    id: json['id'] as String,
    restaurantId: json['restaurantId'] as String,
    subTotalPrice: json['subTotalPrice'] as String,
    deliveryPrice: json['deliveryPrice'] as String,
    totalPrice: json['totalPrice'] as String,
    latitudeC: json['latitudeC'] as String,
    longitudeC: json['longitudeC'] as String,
    latitudeR: json['latitudeR'] as String,
    longitudeR: json['longitudeR'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$LocalOrderToJson(LocalOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'subTotalPrice': instance.subTotalPrice,
      'deliveryPrice': instance.deliveryPrice,
      'totalPrice': instance.totalPrice,
      'latitudeC': instance.latitudeC,
      'longitudeC': instance.longitudeC,
      'latitudeR': instance.latitudeR,
      'longitudeR': instance.longitudeR,
      'userId': instance.userId,
    };
