import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/categories_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Inventory",
      theme: AppTheme.lightTheme,
      home: CategoriesScreen(),
    );
  }
}