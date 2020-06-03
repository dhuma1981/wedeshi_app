class Product {
  int productId;
  int brandId;
  int catId;
  int subCatId;
  int sscId;
  String brandName;
  String categoryName;
  String subCategoryName;
  String productName;
  String productDescription;
  String productImagePath;
  int isVisible;
  String cDate;

  Product(
      {this.productId,
      this.brandId,
      this.catId,
      this.subCatId,
      this.sscId,
      this.brandName,
      this.categoryName,
      this.subCategoryName,
      this.productName,
      this.productDescription,
      this.productImagePath,
      this.isVisible,
      this.cDate});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    brandId = json['brand_id'];
    catId = json['cat_id'];
    subCatId = json['sub_cat_id'];
    sscId = json['ssc_id'];
    brandName = json['brand_name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productImagePath = json['product_image_path'];
    isVisible = json['is_visible'];
    cDate = json['c_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['brand_id'] = this.brandId;
    data['cat_id'] = this.catId;
    data['sub_cat_id'] = this.subCatId;
    data['ssc_id'] = this.sscId;
    data['brand_name'] = this.brandName;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_image_path'] = this.productImagePath;
    data['is_visible'] = this.isVisible;
    data['c_date'] = this.cDate;
    return data;
  }
}
