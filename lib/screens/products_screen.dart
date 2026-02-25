import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import '../models/category.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final Category category;
  final controller = Get.find<InventoryController>();

  ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),

      body: Obx(() {
        final products = controller.productsByCategory(category.id);

        if (products.isEmpty) {
          return const Center(child: Text("No products yet"));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) => ProductCard(product: products[i]),
          ),
        );
      }),
    );
  }
}