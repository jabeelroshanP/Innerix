import 'package:dio/dio.dart';
import 'package:innerix/model/best_offers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BestOfferService {
  Dio dio = Dio();
  final baseUrl = 'https://app.ecominnerix.com/api/v1/home';

  Future<List<BestOfferModel>> getBestOffers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data["best_offers"]["items"] as List;
        return data.map((e) => BestOfferModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch best offers");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
