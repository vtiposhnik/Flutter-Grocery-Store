import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namer_app/models/category_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      appBar: appBar(),
      body: Column(children: [
        _searchField(),
        Column(
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
                    width: 100,
                    height: 100,
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
        )
      ]),
    );
  }

  Container _searchField() {
    return Container(
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

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Goods',
        style: TextStyle(color: Colors.black, fontSize: 19),
      ),
      backgroundColor: Colors.green.shade400,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(),
          child: SvgPicture.asset('./assets/icons/arrow-left.svg'),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(),
            child: SvgPicture.asset('./assets/icons/add-circle-button.svg'),
          ),
        ),
      ],
    );
  }
}
