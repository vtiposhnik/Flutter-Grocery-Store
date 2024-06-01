import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryModel {
  String name;
  String icon;
  Color color;

  CategoryModel({required this.name, required this.icon, required this.color});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
        CategoryModel(name: 'Dairy', icon: './', color: Color(0xFF2196F4)));
    categories.add(CategoryModel(
        name: 'Drinks', icon: './', color: Color.fromARGB(255, 122, 196, 70)));
    categories.add(CategoryModel(
        name: 'Meat', icon: './', color: Color.fromARGB(255, 175, 117, 51)));
    categories.add(CategoryModel(
        name: 'Baked', icon: './', color: Color.fromARGB(255, 255, 251, 7)));
    categories.add(CategoryModel(
        name: 'Sweets', icon: './', color: Color.fromARGB(255, 228, 99, 170)));
    categories.add(CategoryModel(
        name: 'Alcohol', icon: './', color: Color.fromARGB(255, 244, 63, 63)));

    return categories;
  }
}
