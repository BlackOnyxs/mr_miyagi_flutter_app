// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return FoodModel(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    photoUrl: json['photoUrl'] as String,
    type: json['type'] as String,
    model: json['model'] as String,
    ingredients: (json['ingredients'] as List)
        ?.map((e) => e == null
            ? null
            : IngredientModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    state: json['state'] as bool,
    cant: json['cant'] as int,
  );
}

Map<String, dynamic> _$FoodModelToJson(FoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'photoUrl': instance.photoUrl,
      'type': instance.type,
      'model': instance.model,
      'ingredients': instance.ingredients?.map((e) => e?.toJson())?.toList(),
      'description': instance.description,
      'state': instance.state,
      'cant': instance.cant,
    };
