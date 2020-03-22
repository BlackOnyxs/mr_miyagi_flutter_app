// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_section_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuSectionBase _$MenuSectionBaseFromJson(Map<String, dynamic> json) {
  return MenuSectionBase(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    photoUrl: json['photoUrl'] as String,
    iconName: json['iconName'] as String,
  );
}

Map<String, dynamic> _$MenuSectionBaseToJson(MenuSectionBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'iconName': instance.iconName,
    };
