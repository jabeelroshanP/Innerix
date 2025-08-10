class CarouselModel {
  final String title;
  final int offerId;
  final int shopId;
  final String name;
  final String description;
  final String offerType;
  final String rate;
  final String image;

  CarouselModel({
    required this.title,
    required this.offerId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.offerType,
    required this.rate,
    required this.image,
  });

  factory CarouselModel.fromJson(String title, Map<String, dynamic> json) {
    return CarouselModel(
      title: title,
      offerId: json['offer_id'] is int
          ? json['offer_id']
          : int.tryParse(json['offer_id'].toString()) ?? 0,
      shopId: json['shop_id'] is int
          ? json['shop_id']
          : int.tryParse(json['shop_id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      offerType: json['offer_type']?.toString() ?? '',
      rate: json['rate']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  static List<CarouselModel> fromJsonList(Map<String, dynamic> json) {
    final title = json['offers']?['title']?.toString() ?? '';
    final items = json['offers']?['items'] as List? ?? [];
    return items
        .map(
          (item) => CarouselModel.fromJson(title, item as Map<String, dynamic>),
        )
        .toList();
  }
}
