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
            child: Image.network(
              product.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),

                const SizedBox(height: 4),

                Text(product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),

                const SizedBox(height: 6),

                Text("\$${product.price}",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),

                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => controller.decreaseStock(product),
                        icon: const Icon(Icons.remove_circle_outline)),

                    Text("${product.stock}"),

                    IconButton(
                        onPressed: () => controller.increaseStock(product),
                        icon: const Icon(Icons.add_circle_outline)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}