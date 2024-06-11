import 'package:flutter/material.dart';

class DiscountItemCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final double price;
  final double discountPercentage;

  DiscountItemCard(
      {super.key,
      required this.name,
      required this.price,
      required this.imgUrl,
      required this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
            height: 100,
            width: 150,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$discountPercentage% скидка',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(name),
                Text(
                  '$price Р',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                Text(
                  '${price * (discountPercentage / 100)} Р',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
