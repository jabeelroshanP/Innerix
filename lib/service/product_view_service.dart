import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:innerix/model/product_view_mode.dart';

class ProductService {
  final String baseUrl = "https://app.ecominnerix.com/api/products";
  final Dio dio = Dio();

  Future<ProductModel?> getProductById(int id) async {
    try {
      final response = await dio.get("$baseUrl/$id");

      if (response.data['status'] == true && response.data['product'] != null) {
        return ProductModel.fromJson(response.data['product']);
      }
      return null;
    } catch (e) {
      log("Error fetching product: ${e.toString()}");
      return null;
    }
  }
}
