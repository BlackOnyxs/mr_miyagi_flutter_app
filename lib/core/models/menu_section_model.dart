import 'package:json_annotation/json_annotation.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';

part 'menu_section_model.g.dart';

@JsonSerializable( explicitToJson: true )
class MenuSection {
    String id;
    String displayName;
    String photoUrl;
    List<FoodModel> foods;

    MenuSection({
        this.id,
        this.displayName,
        this.photoUrl,
        this.foods,
    });

    factory MenuSection.fromJson(Map<String, dynamic> json) => _$MenuSectionFromJson(json); 
    Map<String, dynamic> toJson () => _$MenuSectionToJson(this);
}
