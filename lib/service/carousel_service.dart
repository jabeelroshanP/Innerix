import 'package:dio/dio.dart';
import 'package:innerix/model/carousel_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarouselService {
  Dio dio = Dio();
  final baseUrl = 'https://app.ecominnerix.com/api/v1/home';

  Future<List<CarouselModel>> getCarousel() async {
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
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return CarouselModel.fromJsonList(data);
      } else {
        throw Exception("Failed to load offers");
      }
    } catch (e) {
      throw Exception("error on fetching offers $e");
    }
  }
}
