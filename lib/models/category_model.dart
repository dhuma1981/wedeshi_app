class Category {
  int categoryId;
  String name;
  String description;
  String imagePath;
  int visible;

  Category(
      {this.categoryId,
      this.name,
      this.description,
      this.imagePath,
      this.visible});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    imagePath = json['image_path'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    data['visible'] = this.visible;
    return data;
  }
}
