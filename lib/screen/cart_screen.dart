import 'package:flutter/material.dart';
import 'package:namer_app/screen/checkout_screen.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/models/product_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Корзина'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.cart.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cart[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 80,
                  ),
                  title: Text(product.name),
                  subtitle: Text('${product.price} P'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline_rounded),
                    onPressed: () {
                      cartProvider.removeFromCart(product);
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: Colors.green,
                child: Icon(Icons.payment_rounded, color: Colors.white),
              ),
            )
          ],
        ));
  }
}
