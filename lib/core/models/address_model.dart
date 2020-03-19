import 'package:json_annotation/json_annotation.dart';

import 'latlng_model.dart';

part 'address_model.g.dart';

@JsonSerializable( explicitToJson: true )
class AddressModel{
  final String neighborhoodName;
  final String streetName;
  final String houseNumber;
  final String generalDescription;
  LatLng location;
  final String type;

  AddressModel({this.neighborhoodName, this.streetName, this.houseNumber, this.generalDescription, this.location, this.type});

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson () => _$AddressModelToJson(this);

  @override
  String toString() {
    return 'Address{ Neighborhood Name: $neighborhoodName, Street Name: $streetName, House Number: $houseNumber, General Description: $generalDescription, Location: $location}';
  }
}