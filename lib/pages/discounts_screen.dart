import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/category_model.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/pages/addProduct_screen.dart';
import 'package:namer_app/pages/home_screen.dart';
import 'package:namer_app/widgets/Discounts/productItem_widget.dart';
import 'package:provider/provider.dart';

class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Discounts'),
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: SvgPicture.asset('./assets/icons/arrow-left.svg')),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductScreen(),
                  ));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(),
              child: SvgPicture.asset('./assets/icons/add-circle-button.svg'),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _searchField(),
          _categories(),
          SizedBox(height: 40),
          _categoriesFilter(),
          _productsList()
        ],
      ),
    );
  }

  Column _categoriesFilter() {
    return Column(
      children: [
        Text('Categories', style: TextStyle(color: Colors.black, fontSize: 19)),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return Container(
                  width: 80,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: categories[index].color,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    categories[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ));
            },
          ),
        )
      ],
    );
  }

  Flexible _productsList() {
    return Flexible(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Consumer<ProductProvider>(builder: (context, value, child) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: value.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    return ProductItemCard(
                        id: value.products[index].id,
                        name: value.products[index].name,
                        price: value.products[index].price,
                        imgUrl: value.products[index].imageUrl,
                        category: value.products[index].category);
                  });
            })));
  }

  Container _searchField() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Container(
              margin: EdgeInsets.all(10),
              child: SvgPicture.asset('./assets/icons/magnifying-glass.svg',
                  width: 30, height: 30)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: 'Search a product...',
        ),
      ),
    );
  }

  Column _categories() {
    return Column(
      children: [
        Text(
          'Categories',
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),
        SizedBox(height: 25),
        Container(
          height: 140,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: categories[index].color,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Image.asset(
                      './assets/icons/oranges.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(categories[index].name),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
