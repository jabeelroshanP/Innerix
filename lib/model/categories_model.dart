class CategoriesModel {
  final String? categoryid;
  final String? categoryName;
  final String? categoryImage;

  CategoriesModel({
    required this.categoryid,
    required this.categoryImage,
    required this.categoryName,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryid: json['category_id']?.toString() ?? "0",
      categoryName: json['category_name']?.toString() ?? "Unknown",
      categoryImage:
          json['category_image']?.toString() ??
          "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
    );
  }
}
