import 'package:get/get.dart';
import '../models/category.dart';
import '../models/product.dart';

class InventoryController extends GetxController {
  final categories = <Category>[].obs;
  final products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedData();
  }

  void _seedData() {
    final electronics = Category(id: "c1", name: "Electronics");
    final food = Category(id: "c2", name: "Food");

    categories.addAll([electronics, food]);

    products.addAll([
      Product(
        id: "p1",
        categoryId: "c1",
        name: "Laptop",
        description: "High performance laptop",
        image: "https://picsum.photos/200",
        price: 3500,
        stock: 8,
      ),
      Product(
        id: "p2",
        categoryId: "c2",
        name: "Coffee",
        description: "Premium Colombian coffee",
        image: "https://picsum.photos/201",
        price: 15,
        stock: 20,
      ),
    ]);
  }

  List<Product> productsByCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();

  void addCategory(String name) {
    categories.add(Category(id: DateTime.now().toString(), name: name));
  }

  void deleteCategory(String id) {
    products.removeWhere((p) => p.categoryId == id);
    categories.removeWhere((c) => c.id == id);
  }

  void addProduct(Product product) {
    products.add(product);
  }

  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }

  void increaseStock(Product p) {
    p.stock++;
    products.refresh();
  }

  void decreaseStock(Product p) {
    if (p.stock == 0) return;
    p.stock--;
    products.refresh();

    if (p.stock < 5) {
      Get.snackbar("Low Stock", "${p.name} is running out");
    }
  }
}