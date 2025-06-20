class Category {
  final String id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['_id'], name: json['name'], slug: json['slug']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'slug': slug};
  }

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Category.fromJson(item)).toList();
  }
}

class Product {
  final String id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final Category category;
  final bool shipping;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.category,
    required this.shipping,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: Category.fromJson(json['category']),
      shipping: json['shipping'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Product.fromJson(item)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
