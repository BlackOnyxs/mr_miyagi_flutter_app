// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalFood _$LocalFoodFromJson(Map<String, dynamic> json) {
  return LocalFood(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    orderId: json['orderId'] as String,
  );
}

Map<String, dynamic> _$LocalFoodToJson(LocalFood instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'orderId': instance.orderId,
    };
