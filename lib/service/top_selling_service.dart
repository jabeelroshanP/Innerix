import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:innerix/model/top_selling_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopSellingService {
  final String baseUrl = "https://app.ecominnerix.com/api/v1/home";
  final Dio dio = Dio();

  Future<List<TopSellingModel>> getTopSellings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      log("Full API Response: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        final List<TopSellingModel> list = TopSellingModel.fromJsonList(
          data['top_selling_items'],
        );
  
        log("Parsed list length: ${list.length}");
        return list;
      } else {
        throw Exception("Failed to fetch top selling products");
      }
    } catch (e) {
      log("Error fetching top selling products: $e");
      return [];
    }
  }
}
