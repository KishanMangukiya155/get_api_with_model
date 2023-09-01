import 'dart:convert';

import 'package:get_api_with_model/Model/ProductModel.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<ProductModel>?> getProduct() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    print("Response...${jsonDecode(response.body)}");

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
