import 'dart:developer' as dev;

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

var dio = Dio(BaseOptions(
  baseUrl: 'https://fakestoreapi.com/',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 3000,
  //headers: {'Authorization': 'Bearer $apiToken'},
  contentType: 'application/json',
));

class ProductController {
  Future<List<ProductModel>> getProduct() async {
    dynamic respon;
    try {
      var url = 'https://fakestoreapi.com/products';
      respon = await http.get(Uri.parse(url));
      //dev.log(respon.data.toString());
      if (respon.statusCode == 200) {
        return productModelFromJson(respon.body);
      } else {
        dev.log(respon.statusCode.toString());
      }
      // return productModelFromJson(response.data.toString());
    } catch (e) {
      dev.log('Error:$e');
    }
    return productModelFromJson(respon.body);
  }
}
