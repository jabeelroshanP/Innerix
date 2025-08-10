import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:innerix/model/categories_model.dart';
import 'package:innerix/service/home_service.dart';

class CategoriesProvider extends ChangeNotifier {
  bool isLoading = false;
  final ApiService service = ApiService();
  List<CategoriesModel> categoryList = [];

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    categoryList = await service.getCategories();
    log(categoryList.toString());

    isLoading = false;
    notifyListeners();
  }
}
