import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _productsList = [
    Product(id: '1', name: 'Bananas', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Fruits & Berries'),
    Product(id: '2', name: 'Apples', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Fruits & Berries'),
    Product(id: '2', name: 'Grapes', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Fruits & Berries'),
    Product(id: '2', name: 'Cucumber', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Veggies'),
    Product(id: '2', name: 'Bread', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Baked'),
    Product(id: '2', name: 'Milk', price: 45, imageUrl: './assets/productsImg/fruits.svg', category: 'Dairy')
  ];

  List<Product> get products => _productsList;

  void addProduct(Product product) {
    _productsList.add(product);
    notifyListeners();
  }
}