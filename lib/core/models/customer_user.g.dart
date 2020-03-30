// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerUser _$CustomerUserFromJson(Map<String, dynamic> json) {
  return CustomerUser(
    id: json['id'] as String,
    fullName: json['fullName'] as String,
    photoUrl: json['photoUrl'] as String,
    address: (json['address'] as List)
        ?.map((e) =>
            e == null ? null : AddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ordersId: (json['ordersId'] as List)?.map((e) => e as String)?.toList(),
    feedback: json['feedback'] as String,
    email: json['email'] as String,
    activeOrders:
        (json['activeOrders'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CustomerUserToJson(CustomerUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'photoUrl': instance.photoUrl,
      'address': instance.address?.map((e) => e?.toJson())?.toList(),
      'ordersId': instance.ordersId,
      'feedback': instance.feedback,
      'email': instance.email,
      'activeOrders': instance.activeOrders,
    };
