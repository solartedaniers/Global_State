import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final controller = Get.find<InventoryController>();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Image.network(product.image,
                fit: BoxFit.cover, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                Text(product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),

                Text("\$${product.price}",
                    style: const TextStyle(color: Colors.green)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => controller.decreaseStock(product)),
                    Text("${product.stock}"),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => controller.increaseStock(product)),
                  ],
                ),

                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteProduct(product.id),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}