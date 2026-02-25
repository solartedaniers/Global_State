class Product {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String image;
  double price;
  int stock;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
  });
}