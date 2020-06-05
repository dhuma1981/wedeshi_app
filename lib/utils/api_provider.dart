import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wedeshi/models/category_model.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/models/subcategory_model.dart';
import 'package:wedeshi/models/subsubcategory_model.dart';

import 'package:wedeshi/utils/constants.dart';
import 'package:wedeshi/utils/keys.dart';

class ApiProvider {
  static HttpClientWithInterceptor getClient() {
    return HttpClientWithInterceptor.build(interceptors: [
      HeaderInterceptor(),
    ]);
  }

  static getCategories() async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    final response = await getClient()
        .post("${Constants.BASE_REST_URL}/categories", body: map);

    List<Category> categories = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          categories.add(Category.fromJson(temp["data"][i]));
        }
      }
      return categories;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  static getSubCategories(int categoryId) async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    map["category_id"] = categoryId.toString();
    final response = await getClient()
        .post("${Constants.BASE_REST_URL}/sub_all_categories", body: map);

    List<SubCategory> subCategories = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          subCategories.add(SubCategory.fromJson(temp["data"][i]));
        }
      }
      return subCategories;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  static Future<List<SubSubCategory>> getSubSubCategories(
      int subCategoryId) async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    map["sub_category_id"] = subCategoryId.toString();
    final response = await getClient()
        .post("${Constants.BASE_REST_URL}/next_categories", body: map);

    List<SubSubCategory> subsubCategories = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          subsubCategories.add(SubSubCategory.fromJson(temp["data"][i]));
        }
      }
      return subsubCategories;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  static Future<List<Product>> getProductList(
      {int subcategoryId, int subsubCategoryId}) async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    if (subcategoryId != null)
      map["sub_category_id"] = subcategoryId.toString();
    if (subsubCategoryId != null)
      map["next_cat_id"] = subsubCategoryId.toString();
    final response = await getClient()
        .post("${Constants.BASE_REST_URL}/products", body: map);

    List<Product> products = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          products.add(Product.fromJson(temp["data"][i]));
        }
      }
      return products;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    map["query"] = query;
    final response =
        await getClient().post("${Constants.BASE_REST_URL}/search", body: map);

    List<Product> products = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          products.add(Product.fromJson(temp["data"][i]));
        }
      }
      return products;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  static Future<Product> getProduct({int productId}) async {
    var map = new Map<String, dynamic>();
    map["secret"] = Keys.TOKEN;
    map["product_id"] = productId.toString();
    final response = await getClient()
        .post("${Constants.BASE_REST_URL}/get_product", body: map);

    List<Product> products = [];
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);

      if (temp["status"]) {
        for (int i = 0; i < temp["data"].length; i++) {
          products.add(Product.fromJson(temp["data"][i]));
        }
      }
      return products[0];
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }
}

class HeaderInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      data.headers['X-Auth-Key'] = Keys.X_Auth_Key;
      data.headers['X-Auth-O-Key'] = Keys.X_Auth_O_Key;
      data.headers['Content-type'] = "application/x-www-form-urlencoded";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}
