class BestOfferModel {
  final int? productId;
  final String? sku;
  final int? loyaltyEarningPoints;
  final int? minLoyaltyPointsRequired;
  final String? name;
  final String? description;
  final String? shortDescription;
  final String? thumbnailImage;
  final int? stockQuantity;
  final bool? inStock;
  final bool? featuredTag;
  final bool? cancelAvailable;
  final bool? returnAvailable;
  final bool? replacementAvailable;
  final bool? cashOnDeliveryAvailable;
  final double? price;
  final String? offerInfo;

  BestOfferModel({
    this.productId,
    this.sku,
    this.loyaltyEarningPoints,
    this.minLoyaltyPointsRequired,
    this.name,
    this.description,
    this.shortDescription,
    this.thumbnailImage,
    this.stockQuantity,
    this.inStock,
    this.featuredTag,
    this.cancelAvailable,
    this.returnAvailable,
    this.replacementAvailable,
    this.cashOnDeliveryAvailable,
    this.price,
    this.offerInfo,
  });

  factory BestOfferModel.fromJson(Map<String, dynamic> json) {
    return BestOfferModel(
      productId: json['product_id'],
      sku: json['sku'],
      loyaltyEarningPoints: json['loyalty_earning_points'],
      minLoyaltyPointsRequired: json['min_loyalty_points_required'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['short_description'],
      thumbnailImage: json['thumbnail_image'],
      stockQuantity: json['stock_quantity'],
      inStock: json['in_stock'],
      featuredTag: json['featured_tag'],
      cancelAvailable: json['cancel_available'],
      returnAvailable: json['return_available'],
      replacementAvailable: json['replacement_available'],
      cashOnDeliveryAvailable: json['cash_on_delivery_available'],
      price: (json['price'] != null)
          ? double.tryParse(json['price'].toString())
          : null,
      offerInfo: json['offer_info'],
    );
  }
}
