class MenuSectionBase {
    String id;
    String displayName;
    String iconName;

    MenuSectionBase({
        this.id,
        this.displayName,
        this.iconName,
    });

    MenuSectionBase.fromData(Map<String, dynamic> data) 
    :   id          = data["id"],
        displayName = data["displayName"],
        iconName    = data["iconName"];

    Map<String, dynamic> toMap() => {
        "id"       : id,
        "name"     : displayName,
        "iconName" : iconName,
    };
}
