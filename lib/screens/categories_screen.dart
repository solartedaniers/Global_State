import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventory_controller.dart';
import 'products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final controller = Get.put(InventoryController());
  final TextEditingController nameCtrl = TextEditingController();

  CategoriesScreen({super.key});

  void _addCategory() {
    Get.defaultDialog(
      title: "New Category",
      content: TextField(controller: nameCtrl),
      onConfirm: () {
        controller.addCategory(nameCtrl.text);
        nameCtrl.clear();
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        child: const Icon(Icons.add),
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (_, i) {
              final category = controller.categories[i];
              return ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.deleteCategory(category.id),
                ),
                onTap: () => Get.to(() => ProductsScreen(category: category)),
              );
            },
          )),
    );
  }
}