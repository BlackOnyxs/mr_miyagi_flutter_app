import 'package:json_annotation/json_annotation.dart';

part 'local_food.g.dart';

@JsonSerializable( explicitToJson: true)
class LocalFood {
  String id;
  String name;
  String price;
  String orderId;

  LocalFood({
    this.id,
    this.name,
    this.price,
    this.orderId
  });

  factory LocalFood.fromJson(Map<String, dynamic> json) => _$LocalFoodFromJson(json);
  Map<String, dynamic> toJson() => _$LocalFoodToJson(this);
   /* Map<String, dynamic> toJson() => {
    "id": id,
    "name" : price,
    "orderId" : orderId,

  }; */

}