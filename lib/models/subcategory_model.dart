class SubCategory {
  int subCategoryId;
  int categoryId;
  String categoryName;
  String subCategoryName;
  String description;
  String imagePath;
  int isVisible;

  SubCategory(
      {this.subCategoryId,
      this.categoryId,
      this.categoryName,
      this.subCategoryName,
      this.description,
      this.imagePath,
      this.isVisible});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    description = json['description'];
    imagePath = json['image_path'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    data['is_visible'] = this.isVisible;
    return data;
  }
}
