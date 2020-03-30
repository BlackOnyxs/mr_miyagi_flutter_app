import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';

part 'customer_user.g.dart';
@JsonSerializable( explicitToJson: true )
class CustomerUser{
  //TODO: add de properties of our aplication

  final String id;
  final String fullName;
  final String photoUrl;
  List<AddressModel> address;
  List<String> ordersId;
  final String feedback;
  final String email;
  List<String> activeOrders;

  CustomerUser({
    this.id,
    this.fullName, 
    this.photoUrl,
    this.address, 
    this.ordersId,
    this.feedback,
    this.email,
    this.activeOrders,
  });

  factory CustomerUser.fromJson(Map<String, dynamic> json) => _$CustomerUserFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerUserToJson(this);
}