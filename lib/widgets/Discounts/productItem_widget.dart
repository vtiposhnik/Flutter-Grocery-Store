import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItemCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imgUrl;
  final String category;

  ProductItemCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$price P',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.add))
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
