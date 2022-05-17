class Product {
  final String title;
  final String thumbnail;
  final String price;
  final int discountRate;

  Product({
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.discountRate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        title: json['title'],
        thumbnail: json["thumbnail"],
        price: json["price"],
        discountRate: json["discountRate"]);
  }
}
