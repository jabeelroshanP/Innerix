import 'package:flutter/foundation.dart';
import 'package:innerix/model/best_offers_model.dart';
import 'package:innerix/service/best_offers.dart';

class BestOfferProvider extends ChangeNotifier {
  final BestOfferService bestOfferService = BestOfferService();

  List<BestOfferModel> bestOffers = [];
  bool isLoading = false;
  String? errorMessage;


  Future<void> fetchBestOffers() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final offers = await bestOfferService.getBestOffers();
      bestOffers = offers;
      errorMessage = null;
    } catch (e) {
      bestOffers = [];
      errorMessage = e.toString();
      if (kDebugMode) {
        print("Error fetching best offers: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}