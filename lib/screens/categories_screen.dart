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
      appBar: AppBar(title: const Text("Inventory Categories")),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCategoryDialog,
        icon: const Icon(Icons.add),
        label: const Text("New Category"),
      ),

      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: controller.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (_, i) {
                final category = controller.categories[i];

                return GestureDetector(
                  onTap: () =>
                      Get.to(() => ProductsScreen(category: category)),
                  child: Card(
                    child: Center(
                      child: Text(
                        category.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

  void _addCategoryDialog() {
    final ctrl = TextEditingController();

    Get.dialog(
      AlertDialog(
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
      ),
    );
  }
}