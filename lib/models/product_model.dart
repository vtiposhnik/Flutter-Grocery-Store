import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool discounted = false;
  final double discountPercentage = 0.0;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.category,
      required discounted,
      discountPercentage = 0.0});
      
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'discounted': discounted,
      'discountPercentage': discountPercentage,
    };
  }
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _productsList = [
    Product(
      id: 'p1',
      name: 'Бананы',
      price: 45.0,
      imageUrl: './assets/productsImg/fruits.svg',
      category: 'Фрукты',
      discounted: false,
    ),
    Product(
      id: 'p2',
      name: 'Яблоки',
      price: 60.0,
      imageUrl: './assets/productsImg/fruits.svg',
      category: 'Фрукты',
      discounted: true, // This product is discounted
    ),
    Product(
      id: 'p3',
      name: 'Молоко',
      price: 80.0,
      imageUrl: './assets/productsImg/fruits.svg',
      category: 'Молочные продукты',
      discounted: false,
    ),
    Product(
      id: 'p4',
      name: 'Хлеб',
      price: 30.0,
      imageUrl: './assets/productsImg/fruits.svg',
      category: 'Выпечка',
      discounted: true, // This product is discounted
    ),
    Product(
      id: 'p5',
      name: 'Курица',
      price: 150.0,
      imageUrl: './assets/productsImg/fruits.svg',
      category: 'Мясо',
      discounted: false,
    ),
  ];

  List<Product> get products => _productsList;

  void addProduct(Product product) {
    _productsList.add(product);
    notifyListeners();
  }
}
