import 'package:json_annotation/json_annotation.dart';

part 'ingredient_model.g.dart';
@JsonSerializable( explicitToJson: true )
class IngredientModel {
    String id;
    String name;
    String price;
    bool status;
    IngredientModel({
        this.id,
        this.name,
        this.price,
        this.status,
    });

    factory IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);

    Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
    @override
  String toString() {
    return "Ingredient{ name: $name, id: $id}";
  }
}
