import 'package:json_annotation/json_annotation.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';

part 'daily_lunch_model.g.dart';
@JsonSerializable( explicitToJson: true)
class DailyLunchModel{
  String id;
  String displayName;
  FoodModel food;


  DailyLunchModel({
    this.displayName,
    this.id,
    this.food
  });

  factory DailyLunchModel.fromJson(Map<String, dynamic> json) => _$DailyLunchModelFromJson(json);
  Map<String, dynamic> toJson () => _$DailyLunchModelToJson(this);
}