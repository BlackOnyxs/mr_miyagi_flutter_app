import 'package:json_annotation/json_annotation.dart';

part 'menu_section_base.g.dart';

@JsonSerializable( explicitToJson: true )
class MenuSectionBase {
    String id;
    String displayName;
    String photoUrl;
    String iconName;

    MenuSectionBase({
        this.id,
        this.displayName,
        this.photoUrl,
        this.iconName,
    });

    factory MenuSectionBase.fromJson(Map<String, dynamic> json) => _$MenuSectionBaseFromJson(json); 
    Map<String, dynamic> toJson () => _$MenuSectionBaseToJson(this);
}
