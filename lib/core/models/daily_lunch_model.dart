import 'package:json_annotation/json_annotation.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';

part 'daily_lunch_model.g.dart';
@JsonSerializable( explicitToJson: true)
class DailyLunchModel{
  String id;
  String displayName;
  FoodModel food;
  String price;


  DailyLunchModel({
    this.displayName,
    this.id,
    this.food,
    this.price,
  });

  factory DailyLunchModel.fromJson(Map<String, dynamic> json) => _$DailyLunchModelFromJson(json);
  Map<String, dynamic> toJson () => _$DailyLunchModelToJson(this);
}