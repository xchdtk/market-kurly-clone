class Category {
  final String icon;
  final String title;
  final List<dynamic> subCategory;

  Category({
    required this.icon,
    required this.title,
    required this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      icon: json['icon'],
      title: json["title"],
      subCategory: json['subCategory'],
    );
  }
}
