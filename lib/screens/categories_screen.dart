import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import 'products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final controller = Get.put(InventoryController());

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Dashboard")),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCategoryDialog,
        icon: const Icon(Icons.add),
        label: const Text("New Category"),
      ),

      body: Obx(() => Column(
            children: [
              _buildGlobalSummary(),
              Expanded(child: _buildCategoriesGrid()),
            ],
          )),
    );
  }

  Widget _buildGlobalSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text("Total Inventory Value",
              style: TextStyle(color: Colors.white70)),

          Obx(() => Text(
                "\$ ${controller.totalValue.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),

          Obx(() => Text(
                "${controller.totalUnits} units available",
                style: const TextStyle(color: Colors.white70),
              )),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: controller.categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (_, i) {
          final category = controller.categories[i];

          return GestureDetector(
            onTap: () => Get.to(() => ProductsScreen(category: category)),
            child: Card(
              child: Stack(
                children: [
                  Center(
                    child: Text(category.name,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .titleLarge),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          controller.deleteCategory(category.id),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addCategoryDialog() {
    final ctrl = TextEditingController();

    Get.dialog(AlertDialog(
      title: const Text("Create Category"),
      content: TextField(controller: ctrl),
      actions: [
        TextButton(onPressed: Get.back, child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            controller.addCategory(ctrl.text);
            Get.back();
          },
          child: const Text("Save"),
        )
      ],
    ));
  }
}