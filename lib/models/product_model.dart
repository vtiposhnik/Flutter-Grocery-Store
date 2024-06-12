import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool discounted;
  final double discountPercentage;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.category,
      required this.discounted,
      required this.discountPercentage});

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
  List<Product> _productsList = [];
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  List<Product> get products => _productsList;

  void addProduct(Product product) {
    _productsList.add(product);
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').where('discountPercentage', isGreaterThan: 0).get();
      final products = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product(
          id: doc.id,
          name: data['name'],
          price: data['price'].toDouble(),
          imageUrl: data['imageUrl'],
          discounted: data['discounted'],
          discountPercentage: data['discountPercentage'].toDouble(),
          category: data['category'],
        );
      }).toList();
      _productsList = products;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in _cart) {
      totalPrice += item.price;
    }
    return totalPrice;
  }
}
