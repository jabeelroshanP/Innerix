import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:innerix/model/top_selling_Model.dart';
import 'package:innerix/service/top_selling_service.dart';

class TopSellingProvider extends ChangeNotifier {
  final TopSellingService topSellingService = TopSellingService();

  List<TopSellingModel> topSellingList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchTopSelling() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final products = await topSellingService.getTopSellings();
      topSellingList = products;
      errorMessage = null;
    } catch (e) {
      topSellingList = [];
      errorMessage = e.toString();
     
        log("Error fetching top selling products: $e");
      
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}