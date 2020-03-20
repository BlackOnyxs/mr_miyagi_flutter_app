import 'package:json_annotation/json_annotation.dart';

part 'promotion_model.g.dart';


@JsonSerializable( explicitToJson: true )
class PromotionModel{
  final String id;
  final String name;
  final String photoUrl;
  final List<String> productId;
  final List<String> descId;
  final String restId;
  final String typeService;

  PromotionModel({
    this.id,
    this.name,
    this.descId,
    this.photoUrl,
    this.productId,
    this.restId,
    this.typeService
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => _$PromotionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionModelToJson(this);

}