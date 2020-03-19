import 'package:json_annotation/json_annotation.dart';

part 'local_order.g.dart';

@JsonSerializable( explicitToJson: true )
class LocalOrder {

  String id;
  String restaurantId;
  String subTotalPrice;
  String deliveryPrice;
  String totalPrice;
  String latitudeC;
  String longitudeC;
  String latitudeR;
  String longitudeR;
  String userId;

  LocalOrder({
    this.id,
    this.restaurantId,
    this.subTotalPrice,
    this.deliveryPrice,
    this.totalPrice,
    this.latitudeC,
    this.longitudeC,
    this.latitudeR,
    this.longitudeR,
    this.userId
  });

  factory LocalOrder.fromJson(Map<String, dynamic> json) => _$LocalOrderFromJson(json);
  Map<String, dynamic> toJson() => _$LocalOrderToJson(this);
}