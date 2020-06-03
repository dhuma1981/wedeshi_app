class SubSubCategory {
  int subSubId;
  int subCategoryId;
  String subCategoryName;
  String categoryName;
  String name;
  String description;
  String imagePath;
  int isVisible;

  SubSubCategory(
      {this.subSubId,
      this.subCategoryId,
      this.subCategoryName,
      this.categoryName,
      this.name,
      this.description,
      this.imagePath,
      this.isVisible});

  SubSubCategory.fromJson(Map<String, dynamic> json) {
    subSubId = json['sub_sub_id'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    categoryName = json['category_name'];
    name = json['name'];
    description = json['description'];
    imagePath = json['image_path'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_sub_id'] = this.subSubId;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['category_name'] = this.categoryName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    data['is_visible'] = this.isVisible;
    return data;
  }
}
