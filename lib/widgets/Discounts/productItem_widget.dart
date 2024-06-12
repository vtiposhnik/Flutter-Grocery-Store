import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/screen/product_details_screen.dart';

class ProductItemCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imgUrl;
  final String category;
  final double discountPercentage;

  ProductItemCard(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.imgUrl,
      required this.category,
      required this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    final product = Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imgUrl,
      category: category,
      discounted: false,
      discountPercentage: discountPercentage,
    );

    final cartProvider = Provider.of<ProductProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              imageUrl: imgUrl,
              discountText: name,
              productName: name,
              price: price,
              discountPercentage: discountPercentage,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Image.network(
              imgUrl,
              width: 100,
              height: 100,
            )),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$price P',
                    style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.red.shade300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${price * discountPercentage / 100} P',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            cartProvider.addToCart(product);
                          },
                          child: Icon(Icons.add))
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
