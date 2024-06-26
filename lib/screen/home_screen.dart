import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namer_app/models/product_model.dart';
import 'package:namer_app/screen/cart_screen.dart';
import 'package:namer_app/screen/profile_screen.dart';
import 'package:namer_app/widgets/HomePage/discountItem_widget.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/models/user_model.dart';
import '../models/category_model.dart';
import 'discounts_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int points = 0;
  List<CategoryModel> categories = [];
  // Map<String, dynamic>? currentUser;

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
              children: [_currentBonusPts(), _mainMenuBar(), _discounts()]),
        ),
        bottomNavigationBar: _bottomNavbar());
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Привет, ${context.watch<UserProvider>().user!['username']}!',
        style: TextStyle(
            color: Colors.yellow, fontSize: 21, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.green.shade400,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(17),
            decoration: BoxDecoration(),
            child: SvgPicture.asset('./assets/icons/bell.svg',
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  Container _discounts() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
              child: Text(
                'Скидки',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                height: 250,
                child:
                    Consumer<ProductProvider>(builder: (context, value, child) {
                  return FutureBuilder(
                      future: value.fetchProducts(),
                      builder: (context, snapshot) {
                        if (value.products.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.products.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return DiscountItemCard(
                                name: value.products[index].name,
                                price: value.products[index].price,
                                imgUrl: value.products[index].imageUrl,
                                discountPercentage:
                                    value.products[index].discountPercentage);
                          },
                        );
                      });
                }))
          ],
        ));
  }

  Container _currentBonusPts() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green),
      child: Column(
        children: [
          Text(
            'Текущие бонусы:',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            '$points B',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white70)),
            child: Text(
              'Покупки',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Padding _mainMenuBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        height: 200,
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _gridItem('Узнать цену', Icons.qr_code),
            _gridItem('Kushay.ru', Icons.logo_dev),
            _gridItem('Покупки', Icons.shopping_cart),
            _gridItem('Игры', Icons.gamepad),
            _gridItem('Клубы', Icons.star_border_outlined),
            _gridItem('Купоны', Icons.airplane_ticket_outlined),
            _gridItem('Промокоды', Icons.airplane_ticket_rounded),
            _gridItem('Мои списки', Icons.note_add),
          ],
        ),
      ),
    );
  }

  Container _gridItem(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color.fromARGB(255, 233, 230, 230))),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.green,
            ),
            SizedBox(height: 7.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavbar() {
    void onItemTapped(int index) {
      if (!mounted) return;
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiscountsPage()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      }
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Скидки',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Сканнер',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Корзина',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }

  // Column _categories() {
  //   return Column(
  //     children: [
  //       Text('Категории',
  //           textAlign: TextAlign.left,
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 24,
  //               fontWeight: FontWeight.w500)),
  //       SizedBox(height: 25),
  //       Container(
  //         height: 140,
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //         child: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: categories.length,
  //           separatorBuilder: (context, index) => SizedBox(width: 10),
  //           itemBuilder: (context, index) {
  //             return Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                   color: categories[index].color,
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Column(
  //                 children: [
  //                   Image.asset(
  //                     './assets/icons/oranges.png',
  //                     width: 100,
  //                     height: 100,
  //                   ),
  //                   Text(categories[index].name),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }
}
