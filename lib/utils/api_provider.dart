import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:wedeshi/models/category_model.dart';

import 'package:wedeshi/utils/constants.dart';
import 'package:wedeshi/utils/keys.dart';

class ApiProvider {
  static HttpClientWithInterceptor getClient() {
    return HttpClientWithInterceptor.build(interceptors: [
      HeaderInterceptor(),
    ]);
  }

  static Future getCategories() async {
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
