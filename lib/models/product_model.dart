class Product {
  final int? id;
  final String title;
  final String imagePath;
  final String price;
  final String oldPrice;
  final String soldCount;
  final String category;

  Product({
    this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.oldPrice,
    required this.soldCount,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'] as int?,
    title: m['title'] as String,
    imagePath: m['imagePath'] as String,
    price: m['price'] as String,
    oldPrice: m['oldPrice'] as String,
    soldCount: m['soldCount'] as String,
    category: m['category'] as String,
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'title': title,
    'imagePath': imagePath,
    'price': price,
    'oldPrice': oldPrice,
    'soldCount': soldCount,
    'category': category,
  };

  Product copyWith({
    int? id,
    String? title,
    String? imagePath,
    String? price,
    String? oldPrice,
    String? soldCount,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      soldCount: soldCount ?? this.soldCount,
      category: category ?? this.category,
    );
  }
}
