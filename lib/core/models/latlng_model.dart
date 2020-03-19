import 'package:json_annotation/json_annotation.dart';

part 'latlng_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LatLng{
  double lat;
  double lng;

  LatLng({
    this.lat,
    this.lng
  });

  factory LatLng.fromJson(Map<String, dynamic> json)=> _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

}