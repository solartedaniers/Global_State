import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final Category category;
  final controller = Get.find<InventoryController>();

  ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),

      floatingActionButton: FloatingActionButton(
        onPressed: _addProductSheet,
        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        final list = controller.productsByCategory(category.id);

        if (list.isEmpty) {
          return const Center(child: Text("No products in this category"));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) => ProductCard(product: list[i]),
          ),
        );
      }),
    );
  }

  void _addProductSheet() {
    final name = TextEditingController();
    final desc = TextEditingController();
    final price = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Wrap(
          runSpacing: 12,
          children: [
            const Text("New Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: desc, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: price, decoration: const InputDecoration(labelText: "Price")),

            ElevatedButton(
              onPressed: () {
                controller.addProduct(Product(
                  id: DateTime.now().toString(),
                  categoryId: category.id,
                  name: name.text,
                  description: desc.text,
                  image: "https://picsum.photos/210",
                  price: int.parse(price.text),
                  stock: 10,
                ));
                Get.back();
              },
              child: const Text("Create Product"),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}