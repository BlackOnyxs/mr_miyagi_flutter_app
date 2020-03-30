import 'package:json_annotation/json_annotation.dart';

import 'ingredient_model.dart';

part 'food_model.g.dart';

@JsonSerializable( explicitToJson: true )
class FoodModel {
    String id;
    String displayName;
    String price;
    String photoUrl;
    String type;
    String model;
    List<IngredientModel> ingredients;
    String description;
    bool state;
    int cant;
    FoodModel({
        this.id,
        this.displayName,
        this.price,
        this.photoUrl,
        this.type,
        this.model,
        this.ingredients,
        this.description,
        this.state,
        this.cant
    });

    factory FoodModel.fromJson(Map<String, dynamic> data) => _$FoodModelFromJson(data);

    Map<String, dynamic> toJson () => _$FoodModelToJson(this);
   
    
     @override
  String toString() {
    return "Food{ id:$id, name: $displayName, price: $price,\nphotoUrl: $photoUrl,\ntype: $type, model: $model,\nIngredients:\n$ingredients\ndescription: $description";
  }
}

 
/**
 *  
 * factory FoodModel.fromJson(String str) => FoodModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FoodModel.fromMap(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        photoUrl: json["photoUrl"],
        type: json["type"],
        model: json["model"],
        ingredients: List<IngredientModel>.from(json["Ingredients"].map((x) => IngredientModel.fromMap(x))),
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "photoUrl": photoUrl,
        "type": type,
        "model": model,
        "Ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
        "description": description,
    };
 */
