import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/category_model.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/screen/addProduct_screen.dart';
import 'package:namer_app/screen/cart_screen.dart';
import 'package:namer_app/screen/home_screen.dart';
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
        centerTitle: false,
        title: Text('Скидки'),
        
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
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [_searchField(), _categoriesFilter(), _productsList()],
      ),
    );
  }

  Column _categoriesFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: Text('Категории',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500))),
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  decoration: BoxDecoration(
                      color: categories[index].color,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    categories[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
              return FutureBuilder(
                  future: value.fetchProducts(),
                  builder: (context, snapshot) {
                    if (value.products.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: value.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.7),
                        itemBuilder: (context, index) {
                          return ProductItemCard(
                            id: value.products[index].id,
                            name: value.products[index].name,
                            price: value.products[index].price,
                            imgUrl: value.products[index].imageUrl,
                            category: value.products[index].category,
                            discountPercentage:
                                value.products[index].discountPercentage,
                          );
                        });
                  });
            })));
  }

  Container _searchField() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Container(
              margin: EdgeInsets.all(10),
              child: SvgPicture.asset('./assets/icons/magnifying-glass.svg',
                  width: 30, height: 30)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: 'Найти продукт...',
        ),
      ),
    );
  }
}
