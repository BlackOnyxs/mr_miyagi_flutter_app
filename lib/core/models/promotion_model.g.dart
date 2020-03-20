// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionModel _$PromotionModelFromJson(Map<String, dynamic> json) {
  return PromotionModel(
    id: json['id'] as String,
    name: json['name'] as String,
    descId: (json['descId'] as List)?.map((e) => e as String)?.toList(),
    photoUrl: json['photoUrl'] as String,
    productId: (json['productId'] as List)?.map((e) => e as String)?.toList(),
    restId: json['restId'] as String,
    typeService: json['typeService'] as String,
  );
}

Map<String, dynamic> _$PromotionModelToJson(PromotionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'productId': instance.productId,
      'descId': instance.descId,
      'restId': instance.restId,
      'typeService': instance.typeService,
    };
