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

  final name = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();

  void _addProduct() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Wrap(
          children: [
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
                  image: "https://picsum.photos/202",
                  price: double.parse(price.text),
                  stock: 10,
                ));
                Get.back();
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(onPressed: _addProduct, icon: const Icon(Icons.add))
        ],
      ),
      body: Obx(() {
        final list = controller.productsByCategory(category.id);

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72, // evita overflow
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: list.length,
          itemBuilder: (_, i) => ProductCard(product: list[i]),
        );
      }),
    );
  }
}