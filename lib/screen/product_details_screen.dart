import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String discountText;
  final String productName;
  final double price;
  final double discountPercentage;

  ProductDetailsPage({
    required this.imageUrl,
    required this.discountText,
    required this.productName,
    required this.price,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                height: 200,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 16),
            Text(
              productName.toUpperCase(),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Vivamus elit diam, pellentesque eu iaculis nec, suscipit quis eros.  ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              '$price P',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${price * (discountPercentage / 100)}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Curabitur porta, tellus vel congue interdum, augue enim egestas ante, ac efficitur massa sem eu mauris. Curabitur sollicitudin congue enim, in suscipit ex laoreet mattis. Donec ac quam mi.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
