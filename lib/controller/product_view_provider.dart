import 'package:flutter/material.dart';
import 'package:innerix/model/product_view_mode.dart';
import 'package:innerix/service/product_view_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  ProductModel? product;
  bool isLoading = false;
  String? error;

  Future<void> fetchProduct(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _service.getProductById(id);
    isLoading = false;

    if (result != null) {
      product = result;
    } else {
      error = "Failed to load product.";
    }
    notifyListeners();
  }
}
