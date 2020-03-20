// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_lunch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyLunchModel _$DailyLunchModelFromJson(Map<String, dynamic> json) {
  return DailyLunchModel(
    displayName: json['displayName'] as String,
    id: json['id'] as String,
    food: json['food'] == null
        ? null
        : FoodModel.fromJson(json['food'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DailyLunchModelToJson(DailyLunchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'food': instance.food?.toJson(),
    };
