import 'dart:developer';

class TopSellingModel {
  final String? title;
  final int? productId;
  final String? name;
  final String? description;
  final String? thumbnailImage;
  final double? price;

  TopSellingModel({
    this.title,
    this.productId,
    this.name,
    this.description,
    this.thumbnailImage,
    this.price,
  });

  factory TopSellingModel.fromJson(Map<String, dynamic> json) {
    return TopSellingModel(
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      thumbnailImage: json['thumbnail_image'],
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  static List<TopSellingModel> fromJsonList(Map<String, dynamic> jsonData) {
    try {
      if (jsonData['items'] == null) return [];

      final items = jsonData['items'] as List;
      return items.map((item) => TopSellingModel.fromJson(item)).toList();
    } catch (e) {
      log("Error parsing top selling list: $e");
      return [];
    }
  }
}
