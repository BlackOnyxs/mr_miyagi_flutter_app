// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuSection _$MenuSectionFromJson(Map<String, dynamic> json) {
  return MenuSection(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    photoUrl: json['photoUrl'] as String,
    foods: (json['foods'] as List)
        ?.map((e) =>
            e == null ? null : FoodModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuSectionToJson(MenuSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'foods': instance.foods?.map((e) => e?.toJson())?.toList(),
    };
