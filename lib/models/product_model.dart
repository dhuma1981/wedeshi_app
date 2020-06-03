class Product {
  int productId;
  int brandId;
  int catId;
  int subCatId;
  String subCategoryName;
  int sscId;
  String productName;
  String productDescription;
  String imagePath;
  int isVisible;
  String cDate;

  Product(
      {this.productId,
      this.brandId,
      this.catId,
      this.subCatId,
      this.subCategoryName,
      this.sscId,
      this.productName,
      this.productDescription,
      this.imagePath,
      this.isVisible,
      this.cDate});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    brandId = json['brand_id'];
    catId = json['cat_id'];
    subCatId = json['sub_cat_id'];
    subCategoryName = json['sub_category_name'];
    sscId = json['ssc_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    imagePath = json['image_path'];
    isVisible = json['is_visible'];
    cDate = json['c_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['brand_id'] = this.brandId;
    data['cat_id'] = this.catId;
    data['sub_cat_id'] = this.subCatId;
    data['sub_category_name'] = this.subCategoryName;
    data['ssc_id'] = this.sscId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['image_path'] = this.imagePath;
    data['is_visible'] = this.isVisible;
    data['c_date'] = this.cDate;
    return data;
  }
}
