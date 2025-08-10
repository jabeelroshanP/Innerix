import 'package:flutter/material.dart';
import 'package:innerix/model/carousel_mode.dart';
import 'package:innerix/service/carousel_service.dart';

class CarouselProvider extends ChangeNotifier {
  final CarouselService service = CarouselService();
  List<CarouselModel> listModel = [];
  bool isLoading = false;

  Future<void> getCarousel() async {
    isLoading = true;
    notifyListeners();

    try {
      listModel = await service.getCarousel();
    } catch (e) {
      listModel = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
