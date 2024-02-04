import 'dart:convert';

import 'package:http/http.dart';

import '../model/product.dart';

class ApiService {
  String endPoint = 'https://dummyjson.com/products/1';

  Future<Product> getProduct() async {
    Response response = await get(Uri.parse(endPoint));
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Product.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}