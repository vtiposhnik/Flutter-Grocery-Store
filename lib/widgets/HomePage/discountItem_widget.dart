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
    return Stack(children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.contain,
                  height: 100,
                  width: 150,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '$price Р',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.white70),
                    ),
                    Text(
                      '${price * (discountPercentage / 100)} Р',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      Positioned(
        top: 20,
        right: -15,
        child: Transform.rotate(
          angle: 0.785398, // -45 degrees in radians
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              '$discountPercentage% скидка',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
