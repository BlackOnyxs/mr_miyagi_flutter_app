// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    neighborhoodName: json['neighborhoodName'] as String,
    streetName: json['streetName'] as String,
    houseNumber: json['houseNumber'] as String,
    generalDescription: json['generalDescription'] as String,
    location: json['location'] == null
        ? null
        : LatLng.fromJson(json['location'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'neighborhoodName': instance.neighborhoodName,
      'streetName': instance.streetName,
      'houseNumber': instance.houseNumber,
      'generalDescription': instance.generalDescription,
      'location': instance.location?.toJson(),
      'type': instance.type,
    };
