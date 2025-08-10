class ProductModel {
  final int productId;
  final String sku;
  final int loyaltyEarningPoints;
  final int minLoyaltyPointsRequired;
  final String name;
  final String description;
  final String shortDescription;
  final String? thumbnailImage;
  final int stockQuantity;
  final bool inStock;
  final bool featuredTag;
  final bool cancelAvailable;
  final bool returnAvailable;
  final bool replacementAvailable;
  final bool cashOnDeliveryAvailable;
  final double price;
  final dynamic offerInfo;
  final List<RelatedProductModel> relatedProducts;

  ProductModel({
    required this.productId,
    required this.sku,
    required this.loyaltyEarningPoints,
    required this.minLoyaltyPointsRequired,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.thumbnailImage,
    required this.stockQuantity,
    required this.inStock,
    required this.featuredTag,
    required this.cancelAvailable,
    required this.returnAvailable,
    required this.replacementAvailable,
    required this.cashOnDeliveryAvailable,
    required this.price,
    required this.offerInfo,
    required this.relatedProducts,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'] ?? 0,
      sku: json['sku'] ?? '',
      loyaltyEarningPoints: json['loyalty_earning_points'] ?? 0,
      minLoyaltyPointsRequired: json['min_loyalty_points_required'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      thumbnailImage: json['thumbnail_image'],
      stockQuantity: json['stock_quantity'] ?? 0,
      inStock: json['in_stock'] ?? false,
      featuredTag: json['featured_tag'] ?? false,
      cancelAvailable: json['cancel_available'] ?? false,
      returnAvailable: json['return_available'] ?? false,
      replacementAvailable: json['replacement_available'] ?? false,
      cashOnDeliveryAvailable: json['cash_on_delivery_available'] ?? false,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      offerInfo: json['offer_info'],
      relatedProducts: (json['related_products'] as List<dynamic>? ?? [])
          .map((item) => RelatedProductModel.fromJson(item))
          .toList(),
    );
  }
}

class RelatedProductModel {
  final int productId;
  final String name;
  final String? thumbnailImage;
  final double price;

  RelatedProductModel({
    required this.productId,
    required this.name,
    required this.thumbnailImage,
    required this.price,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) {
    return RelatedProductModel(
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      thumbnailImage: json['thumbnail_image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}
