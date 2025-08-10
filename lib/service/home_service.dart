import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:innerix/model/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio();
  static const baseUrl = "https://app.ecominnerix.com/api/v1/home";

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      log("Fetching categories from $baseUrl");
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      log(response.data.toString());

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null ||
            data['categories'] == null ||
            data['categories']['items'] == null) {
          log("No categories found in response");
          return [];
        }

        final List<dynamic> categoryItems = data['categories']['items'];
        log("Successfully fetched ${categoryItems.length} categories");

        return categoryItems.map((e) => CategoriesModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load categories: Status code ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log("Dio error: ${e.message}");
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
  }
}
